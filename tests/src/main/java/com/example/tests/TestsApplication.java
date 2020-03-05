package com.example.tests;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.ServerResponse;

import static org.springframework.web.reactive.function.server.RequestPredicates.path;
import static org.springframework.web.reactive.function.server.RouterFunctions.route;
import static org.springframework.web.reactive.function.server.ServerResponse.ok;

@SpringBootApplication
public class TestsApplication {

  @Bean
  RouterFunction<ServerResponse> routes() {
    return route().nest(path("/"), builder -> builder.GET("/", request -> ok().render("index"))
                                                     .build())
                  .build()
                  .andRoute(path("/**"), request -> ok().render("redirect:/"));
  }

  public static void main(String[] args) {
    SpringApplication.run(TestsApplication.class, args);
  }
}
