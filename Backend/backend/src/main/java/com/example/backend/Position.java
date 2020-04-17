package com.example.backend;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Position {
    @Id 
    @GeneratedValue( strategy=GenerationType.AUTO )
 
    private int id;
    private float x;
    private float y;
    Position(float x, float y){
        this.x = x;
        this.y = y;
    }
    public float getX(){
        return x;  
    }
    public float getY(){
      return y;  
    }
    public void setX(float x){
        this.x = x;
    }
    public void setY(float y){
        this.y = y;
    }


}