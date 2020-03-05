package com.example.tests;

import com.codeborne.selenide.*;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.web.server.LocalServerPort;

import static com.codeborne.selenide.Condition.*;
import static com.codeborne.selenide.Selenide.$;

@Log4j2
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class TestsApplicationTests {

  @LocalServerPort
  private Integer port;

  @Test
  void test() {

    // ./mvnw test -Dselenide.browser=chrome -Dselenide.headless=true
    if (Browsers.CHROME.equals(Configuration.browser) && Configuration.headless) {
      ChromeOptions chromeOptions = new ChromeOptions().addArguments("--no-sandbox");
      WebDriverRunner.setWebDriver(new ChromeDriver(chromeOptions));
    }

    Selenide.open(String.format("http://127.0.0.1:%d", port));

    SelenideElement body = $("body").shouldBe(exist, visible);
    log.info(body.text());

    body.find("h1")
        .shouldHave(exactTextCaseSensitive("Hello!"));

    body.find("p")
        .shouldHave(textCaseSensitive("How it's going?"))
        .shouldHave(text("e2e?"));

    Selenide.sleep(1234);
  }
}
