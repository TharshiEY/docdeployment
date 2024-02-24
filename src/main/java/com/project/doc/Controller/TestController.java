package com.project.doc.Controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
@RequestMapping("/api/v1")
@RestController()
public class TestController {

    @GetMapping("/test")
    public String Test(){
        return "Hi Test is pass.....";
    }
}
