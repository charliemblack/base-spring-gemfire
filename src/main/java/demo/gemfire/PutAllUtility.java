package demo.gemfire;

import com.gemstone.gemfire.cache.PartitionResolver;
import com.gemstone.gemfire.cache.Region;
import com.gemstone.gemfire.cache.client.internal.ClientMetadataService;
import com.gemstone.gemfire.cache.client.internal.ClientPartitionAdvisor;
import com.gemstone.gemfire.internal.cache.PartitionedRegionHelper;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.Serializable;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.Executor;
import java.util.concurrent.Future;
import java.util.concurrent.FutureTask;
import java.util.concurrent.atomic.AtomicLong;

public class PutAllUtility implements Serializable {

    @Autowired
    private Executor threadPool;
    private static final Object NO_LOCATION = new Object();
    private AtomicLong count = new AtomicLong(0);
    private boolean hasProblem = false;


    public void partitionPuts(ClientMetadataService clientMetadataService, Region region, Map fromData) {
        Map<Object, Map> map = splitByBucket(clientMetadataService, region, fromData);
        doPutAll(region, map);
    }

    public boolean isHasProblem() {
        return hasProblem;
    }

    private void doPutAll(Region region, Map<Object, Map> memberMap) {
        List<Future> futures = new LinkedList<Future>();
        count.addAndGet(memberMap.size());
        for (Map value : memberMap.values()) {
            PutAllFuture putAllTask = new PutAllFuture(region, value);
            threadPool.execute(putAllTask);
            futures.add(putAllTask);
        }
        for (Future task : futures) {
            try {
                // get just blocks..
                task.get();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private class PutAllFuture extends FutureTask {
        public PutAllFuture(final Region region, final Map data) {
            super(new Callable() {
                @Override
                public Object call() throws Exception {
                    try {
                        region.putAll(data);
                    } catch (Exception e) {
                        hasProblem = true;
                    }
                    return null;
                }
            });
        }
    }

    private Map<Object, Map> splitByBucket(ClientMetadataService clientMetadataService, Region region, Map fromData) {
        ClientPartitionAdvisor clientPartitionAdvisor = clientMetadataService.getClientPartitionAdvisor(region.getFullPath());
        int bucketCount = clientPartitionAdvisor.getTotalNumBuckets();

        Map<Object, Map> returnValue = new HashMap<Object, Map>();
        Set<Map.Entry> entrySet = fromData.entrySet();
        for (Map.Entry entry : entrySet) {
            Object key = entry.getKey();
            Object routingObject = key;
            if (key instanceof PartitionResolver) {
                routingObject = ((PartitionResolver) key).getRoutingObject(null);
            }

            try {
                int bucketId = PartitionedRegionHelper.getHashKey(routingObject, bucketCount);
                Object location = clientPartitionAdvisor.advisePrimaryServerLocation(bucketId);
                if (location == null) {
                    location = NO_LOCATION;
                }
                Map dataMap = returnValue.get(location);
                if (dataMap == null) {
                    dataMap = new HashMap();
                    returnValue.put(location, dataMap);
                }
                dataMap.put(key, entry.getValue());
            } catch (Exception e) {
                System.out.println("entry.getValue() = " + entry.getValue());
            }
        }
        return returnValue;
    }
}