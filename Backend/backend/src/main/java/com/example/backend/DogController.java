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

    @Autowired
    private UserRepository userRepo;

    @GetMapping(path = "/all")
    public @ResponseBody List<Dog> allDog() {
        return dogRepository.findAll();
    }

    @GetMapping(path = "/findDog")
    public @ResponseBody Dog findUser(@RequestParam long id) {
        Dog d = dogRepository.findById(id).get();
        return d;
    }

    @PostMapping(value = "/updatedogname")
    public @ResponseBody boolean newNameForDog(@RequestBody long id, String newName) {
        Dog d = dogRepository.findById(id).get();
        if (d != null) {
            d.setName(newName);
            return true;
        } else {
            return false;
        }
    }

    @PostMapping(value = "/updatedogweight")
    public @ResponseBody boolean newWeightForDog(@RequestBody long id, String newWeight) {
        Dog d = dogRepository.findById(id).get();
        if (d != null) {
            d.setWeight(newWeight);
            return true;
        } else {
            return false;
        }
    }

    @PostMapping(value = "/updatedogheight")
    public @ResponseBody boolean newHeightForDog(@RequestBody long id, String newHeight) {
        Dog d = dogRepository.findById(id).get();
        if (d != null) {
            d.setHeight(newHeight);
            return true;
        } else {
            return false;
        }
    }

    @PostMapping(value = "/updatedogdescription")
    public @ResponseBody boolean newDescriptionForDog(@RequestBody long id, String newDescription) {
        Dog d = dogRepository.findById(id).get();
        if (d != null) {
            d.setDescription(newDescription);
            return true;
        } else {
            return false;
        }
    }

    @PostMapping(value = "/updatedogage")
    public @ResponseBody boolean newAgeForDog(@RequestBody long id, String newAge) {
        Dog d = dogRepository.findById(id).get();
        if (d != null) {
            d.setAge(newAge);
            return true;
        } else {
            return false;
        }
    }

    @PostMapping(value = "/setPicture")
    public @ResponseBody String setPicture(@RequestParam long id, String base64) {
        byte[] decodedByte = Base64.getMimeDecoder().decode(base64);
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

    @GetMapping(value = "/getPicture")
    public @ResponseBody String getPic(@RequestParam long id) {
        Dog d = dogRepository.findById(id).get();
        return d.getImage();
    }

    @PostMapping(value = "/deletedog")
    public @ResponseBody String deleteDog(@RequestParam long id, String uid) {
        Optional<Dog> optinalEntity = dogRepository.findById(id);
        Dog d = optinalEntity.get();

        //dogRepository.delete(d);
        User u = userRepo.findByUid(uid);
        u.removeDog(d);
        userRepo.save(u);

        return "true";

    }

    public static byte[] getImage() {
        File file = new File("Java.png");
        if (file.exists()) {
            try {
                BufferedImage bufferedImage = ImageIO.read(file);
                ByteArrayOutputStream byteOutStream = new ByteArrayOutputStream();
                ImageIO.write(bufferedImage, "png", byteOutStream);
                return byteOutStream.toByteArray();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

}