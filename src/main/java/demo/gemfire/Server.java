package demo.gemfire;

import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import java.io.IOException;

/**
 * User: cblack
 */
public class Server {

    public static void main(String[] args) throws IOException {
        try {
            AbstractApplicationContext ctx = new FileSystemXmlApplicationContext(args[0]);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
