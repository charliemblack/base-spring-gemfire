package demo.gemfire.nsn;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.Assert;

import javax.annotation.Resource;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-gemfire.xml")
public class SpringAppTests {

    @Resource(name = "TestData")
    private Map testData;

    @Test
    public void testPut() {
        testData.put("hello", "world");
    }
    @Test
    public void testGet(){
        Assert.isTrue("world".equals(testData.get("hello")));
    }
}
