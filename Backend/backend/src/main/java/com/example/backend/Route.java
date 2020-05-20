package com.example.backend;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.Columns;
import org.hibernate.annotations.Type;
import org.springframework.beans.factory.annotation.Autowired;

@Entity
public class Route {
  @Id
  @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "USERS_SEQ")
  @SequenceGenerator(name = "USERS_SEQ", sequenceName = "SEQUENCE_USERS")
  private Long id;

  private String name;

  @Column(columnDefinition="TEXT")
  private String pos;
 

  Route(){

  }
  Route(String name, String p){
    this.name = name;
    this.pos = p;
    // this.latlng1 = latlng1;
    // this.latlng2 = latlng2;
    // this.latlng3 = latlng3;
  }

  String getName(){
    return this.name;
  }
  
  void setName(String name) {
    this.name = name;
  }

  String getPos(){
    return this.pos;
  }

  // String getRoutes(){
  //   return "https://api.mapbox.com/directions/v5/mapbox/walking/" + latlng1.toString() + ";"
  //    + latlng2.toString() + ";" + latlng3.toString() + ";" + latlng1.toString()
  //    + ".json?access_token=pk.eyJ1IjoibHVjYXMtZG9tZWlqIiwiYSI6ImNrOWIyc2VpaTAxZXEzbGwzdGx5bGsxZjIifQ.pfwWSfqvApF610G-rKFK8A&steps=true&overview=full&geometries=geojson&annotations=distance&continue_straight=true";
  // }
  

}