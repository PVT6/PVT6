package com.example.backend;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Arrays;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;

import com.fasterxml.jackson.annotation.JsonManagedReference;

import org.dom4j.Text;
import org.hibernate.annotations.Columns;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Type;
import org.hibernate.type.ListType;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

@Entity
public class Route {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "USERS_SEQ")
  @SequenceGenerator(name = "USERS_SEQ", sequenceName = "SEQUENCE_USERS")
  @JsonManagedReference
  private Long id;

  @JsonManagedReference
  private String name;

  @JsonManagedReference
  private String distans;

  @OneToOne(fetch = FetchType.LAZY, cascade = { CascadeType.ALL })
  private Position latlng1;
  @OneToOne(fetch = FetchType.LAZY, cascade = { CascadeType.ALL })
  private Position latlng2;
  @OneToOne(fetch = FetchType.LAZY, cascade = { CascadeType.ALL })
  private Position latlng3;


  Route() {

  }

  Route(String name, Position latlng1, Position latlng2, Position latlng3, String distans) {
    this.name = name;
    this.latlng1 = latlng1;
    this.latlng2 = latlng2;
    this.latlng3 = latlng3;
    this.distans = distans;


  }

  

  String getName() {
    return this.name;
  }

  void setName(String name) {
    this.name = name;
  }

 
  String getRoutes() {
    String returnvalue = "";
    HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create("https://api.mapbox.com/directions/v5/mapbox/walking/" + latlng1.toString() + ";"
                        + latlng2.toString() + ";" + latlng3.toString() + ";" + latlng1.toString()
                        + ".json?access_token=pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A&steps=true&overview=full&geometries=geojson&annotations=distance&continue_straight=true"))
                .build();
        try {
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
            returnvalue = response.body();
        } catch (IOException e1) {
         
            e1.printStackTrace();
        } catch (InterruptedException e1) {
           
            e1.printStackTrace();
        }
        return  returnvalue ;
   }

}