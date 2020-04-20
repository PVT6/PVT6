package com.example.backend;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.StreamSupport;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;

import com.github.goober.coordinatetransformation.Position.Grid;
import com.github.goober.coordinatetransformation.positions.SWEREF99Position;
import com.github.goober.coordinatetransformation.positions.WGS84Position;
import com.github.goober.coordinatetransformation.positions.SWEREF99Position.SWEREFProjection;
import com.opencsv.CSVReader;
import com.opencsv.CSVReaderBuilder;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.StatelessSession;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.provider.HibernateUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller // This means that this class is a Controller
@RequestMapping(path = "/light") // This means URL's start with /demo (after Application path)
public class LightController    {
    @Autowired
    
    private LightRepository lightRepository;

    @PersistenceContext
    private EntityManager em;

    @GetMapping(path="/clear")
    public @ResponseBody String clearAll() {
     
      lightRepository.deleteAllInBatch();
      return "Done";
    }
    @GetMapping(path="/all")
    public @ResponseBody Iterable<Light> getAllLights() {
    
      return lightRepository.findAll();
    }
    @GetMapping(path="/{id}")
    public @ResponseBody Optional<Light> getOneLight(@PathVariable("id") long id) {
      
      return lightRepository.findById(id);
    }

    @PostMapping(path = "/update") 
    public @ResponseBody String update() {
      String r = "";
      try {
        URL url = new URL("https://openstreetgs.stockholm.se/geoservice/api/0b9df6fc-fb6f-4d3e-a972-01dede8ac029/wfs?service=wfs&version=1.1.0&request=GetFeature&typeName=od_gis:Belysningsmontage&outputFormat=csv");
        HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
        int responseCode = httpConn.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
          BufferedReader br = new BufferedReader(new InputStreamReader(httpConn.getInputStream()));
          CSVReader csvReader  = new CSVReaderBuilder(br).withSkipLines(1).build();
          String[] nextRecord; 
          /* 
          * FID [0]
          * OBJECT_ID [1]
          * VERSION_ID [2]
          * FEATURE_TYPE_NAME [3]
          * FEATURE_TYPE_OBJECT_ID [4]
          * FEATURE_TYPE_VERSION_ID [5]
          * MAIN_ATTRIBUTE_NAME [6]
          * MAIN_ATTRIBUTE_VALUE [7]
          * MAIN_ATTRIBUTE_DESCRIPTION [8]
          * Montage_ID [9]
          * DP_oid [10]
          * Stadie [11]
          * Placering [12]
          * Drifttagen_datum [13]
          * Omgivning [14]
          * Huvudman [15]
          * Omgivning [16]
          * VALID_FROM [17]
          * VALID_TO [18]
          * CID [19]
          * EXTENT_NO [20]
          * LATERAL_POSITION [21]
          * LATERAL_DIST [22]
          * POSITION [23]
          * GEOMETRY [24] EPSG::3011 POINT (Y , X)
          * TRAFFIC_TYPES [25]
          * NET_ELEMENT_OBJECT_ID [26]
          * CREATE_DATE [27]
          * CHANGE_DATE [28]
          */   
         
          
          int x = 0;
          int batchSize  = 100;

          List<Light> lights = new ArrayList<Light>();

       
     
            while ((nextRecord = csvReader.readNext()) != null) { 
            
              String swerefPosition [] = nextRecord[24].replace("POINT (", "").replace(")", "").split(" ");
              SWEREF99Position position = new SWEREF99Position(Float.parseFloat(swerefPosition[0]), Float.parseFloat(swerefPosition[1]), SWEREFProjection.sweref_99_18_00);
              WGS84Position wgsPos = position.toWGS84();
              Light l = new Light(nextRecord[1], nextRecord[12], nextRecord[14], nextRecord[28], nextRecord[27], wgsPos.getLongitude(), wgsPos.getLatitude());
              lights.add(l);

              x++;
              System.out.println(x);
                if (x % batchSize == 0 && x > 0) {
                  lightRepository.saveAll(lights);
                  lights.clear();
              }
            }
            if (lights.size() > 0){
              lightRepository.saveAll(lights);
              lights.clear();
            }
         
          
      

         r = "Updated";
        }
      } 
      catch (IOException ex) {
        ex.printStackTrace();
        r = "Error";
      }
        return r;
    }
}