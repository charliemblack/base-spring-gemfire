package demo.gemfire;

import com.gemstone.gemfire.cache.Region;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.annotation.Resource;

public class Client {

    @Resource(name = "TestData")
    private Region testData;

    public void publishData(){
        for(int i =0 ; i < 113; i++){
            testData.put(i,i);
        }
    }
    public void listData(){
        System.out.println("testData.getName() = " + testData.getName());
        System.out.println("testData.keySet() = " + testData.keySet());
        System.out.println("testData.keySetOnServer() = " + testData.keySetOnServer());
    }

    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("classpath:spring-gemfire-client.xml");
        Client client = context.getBean("ClientBean", Client.class);
        client.listData();
        client.publishData();
        client.listData();
    }
}
