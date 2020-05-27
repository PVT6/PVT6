package com.example.backend;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.Base64;
import java.util.List;
import java.util.Optional;


import javax.imageio.ImageIO;
import javax.sql.rowset.serial.SerialBlob;
import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller // This means that this class is a Controller
@RequestMapping(path = "/dog")
public class DogController {
    @Autowired
    private DogRepository dogRepository;

    @GetMapping(path = "/all")
    public @ResponseBody List<Dog> allDog() {
        return dogRepository.findAll();
    }

    @GetMapping(path = "/findDog")
    public @ResponseBody Dog findUser(@RequestParam int id) {
        Dog d = dogRepository.findById(id).get();
        return d;
    }

    @PostMapping(value = "/updatedogname")
    public @ResponseBody boolean newNameForDog(@RequestBody int id, String newName) {
        Dog d = dogRepository.findById(id).get();
        if (d != null) {
            d.setName(newName);
            return true;
        } else {
            return false;
        }
    }

    @PostMapping(value = "/updatedogweight")
    public @ResponseBody boolean newWeightForDog(@RequestBody int id, String newWeight) {
        Dog d = dogRepository.findById(id).get();
        if (d != null) {
            d.setWeight(newWeight);
            return true;
        } else {
            return false;
        }
    }

    @PostMapping(value = "/updatedogheight")
    public @ResponseBody boolean newHeightForDog(@RequestBody int id, String newHeight) {
        Dog d = dogRepository.findById(id).get();
        if (d != null) {
            d.setHeight(newHeight);
            return true;
        } else {
            return false;
        }
    }

    @PostMapping(value = "/updatedogdescription")
    public @ResponseBody boolean newDescriptionForDog(@RequestBody int id, String newDescription) {
        Dog d = dogRepository.findById(id).get();
        if (d != null) {
            d.setDescription(newDescription);
            return true;
        } else {
            return false;
        }
    }

    @PostMapping(value = "/updatedogage")
    public @ResponseBody boolean newAgeForDog(@RequestBody int id, String newAge) {
        Dog d = dogRepository.findById(id).get();
        if (d != null) {
            d.setAge(newAge);
            return true;
        } else {
            return false;
        }
    }

    @PostMapping(value = "/setPicture")
    public @ResponseBody String setPicture(@RequestParam int id, String base64) {
        String base64Image = URLEncoder.encode(base64, StandardCharsets.ISO_8859_1);
        byte[] decodedByte = Base64.getDecoder().decode(base64Image);
        try {
            Blob blob = new SerialBlob(decodedByte);
            Dog d = dogRepository.findById(id).get();
            d.setBlobImage(blob);
            dogRepository.save(d);

        } catch (SerialException e) {
        
            e.printStackTrace();
        } catch (SQLException e) {
    
            e.printStackTrace();
        }

        return "";
        
     }


     @DeleteMapping(value = "/deletedog")
     public @ResponseBody boolean deleteDog(@RequestBody int id) {
            Optional<Dog> optinalEntity = dogRepository.findById(id);
            Dog d = optinalEntity.get();
            if(d != null){
                dogRepository.delete(d);
                return true;
            }else{
                return false;
            }
    }


    public static byte[] getImage() {
        File file =new File("Java.png");
        if(file.exists()){
           try {
              BufferedImage bufferedImage=ImageIO.read(file);
              ByteArrayOutputStream byteOutStream=new ByteArrayOutputStream();
              ImageIO.write(bufferedImage, "png", byteOutStream);
              return byteOutStream.toByteArray();
           } catch (IOException e) {
              e.printStackTrace();
           }
        }
        return null;
     }

}