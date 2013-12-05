package demo.gemfire;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.io.IOException;

public class Server {

    public static void main(String[] args) throws IOException {
        try {
            AbstractApplicationContext ctx = new ClassPathXmlApplicationContext("classpath:spring-gemfire-server.xml");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
