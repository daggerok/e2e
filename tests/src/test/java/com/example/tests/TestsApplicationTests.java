package com.example.tests;

import com.codeborne.selenide.Selenide;
import com.codeborne.selenide.SelenideElement;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.web.server.LocalServerPort;

import static com.codeborne.selenide.Condition.*;
import static com.codeborne.selenide.Selenide.$;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class TestsApplicationTests {

  @LocalServerPort
  private Integer port;

  @Test
  void contextLoads() {
    Selenide.open(String.format("http://127.0.0.1:%d", port));

    SelenideElement body = $("body").shouldBe(exist, visible);

    body.find("h1")
        .shouldHave(exactTextCaseSensitive("Hello!"))
    ;

    body.find("p")
        .shouldHave(textCaseSensitive("How it's going?"))
        .shouldHave(text("e2e?"))
    ;

    Selenide.sleep(1234);
  }
}
