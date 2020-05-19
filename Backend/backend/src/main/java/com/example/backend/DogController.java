package com.example.backend;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.DeleteMapping;

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

    @PostMapping(value="/updatedogname")
     public @ResponseBody boolean newNameForDog(@RequestBody int id, String newName) {
            Dog d = dogRepository.findById(id).get();
            if(d != null){
                d.setName(newName);
                return true;
            }else{
                return false;
            }
     }

     @PostMapping(value="/updatedogweight")
     public @ResponseBody boolean newWeightForDog(@RequestBody int id, String newWeight) {
        Dog d = dogRepository.findById(id).get();
        if(d != null){
            d.setWeight(newWeight);
            return true;
        }else{
            return false;
        }
     }

     @PostMapping(value="/updatedogage")
     public @ResponseBody boolean newAgeForDog(@RequestBody int id, String newAge) {
        Dog d = dogRepository.findById(id).get();
        if(d != null){
            d.setAge(newAge);
            return true;
        }else{
            return false;
        }
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

}