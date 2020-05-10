package com.example.backend;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller // This means that this class is a Controller
@RequestMapping(path = "/route")
public class RoutesController {

    @GetMapping(path = "/test")
    public @ResponseBody String testRoute() {
        return "go";
    }
    @GetMapping(path = "/new")
    public @ResponseBody String generateRoute(@RequestParam Double posX, Double posY, int distans) {
        String returnvalue = "";
        double o = posY * Math.PI / 180;
        double i = posX * Math.PI / 180;
        double h = 5 * 0.609344;
        double m = 5 * 0.609344;
        double k = Math.PI / 180 * ((120 - 60) * Math.random() + 60);
        double f = 0.85;
        double p = f * m / (2 + 2 * Math.sin(k / 2));
        double c = 4000 * Math.cos(o);
        double d = 2 * Math.random() * Math.PI;
        double n = p * Math.cos(d) / 4000 + o;
        double g = i + p * Math.sin(d) / c;
        double l = p * Math.cos(d + k) / 4000 + o;
        double e = i + p * Math.sin(d + k) / c;
        Position latlng1 = new Position((posX), (posY));
        Position latlng2 = new Position((g * 180 / Math.PI), (n * 180 / Math.PI));
        Position latlng3 = new Position((e * 180 / Math.PI), (l * 180 / Math.PI));

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
