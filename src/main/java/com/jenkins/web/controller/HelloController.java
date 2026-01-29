package com.jenkins.web.controller;

import org.springframework.web.bind.annotation.*;

@RestController
public class HelloController {

    @GetMapping("/hello")
    public String sayHello() {
        return "Hello, World! Your Spring Boot is up and running.";
    }
    //ready to push into EKS
}