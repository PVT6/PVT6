package com.example.backend;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;

import org.hibernate.annotations.GenericGenerator;

@Entity
public class Position {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "USERS_SEQ")
    @SequenceGenerator(name = "USERS_SEQ", sequenceName = "SEQUENCE_USERS")

    private Long id;
    private Double x;
    private Double y;

   

    
    Position(){};
    Position(Double x, Double y){
        this.x = x;
        this.y = y;
    }
    public Double getX(){
        return x;  
    }
    public Double getY(){
      return y;  
    }
    public void setX(Double x){
        this.x = x;
    }
    public void setY(Double y){
        this.y = y;
    }


}