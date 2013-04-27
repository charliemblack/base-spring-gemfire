package demo.gemfire;

import com.gemstone.gemfire.cache.PartitionResolver;
import com.gemstone.gemfire.pdx.PdxInstance;
import demo.vmware.finra.data.JoinKeyLandingZone;
import demo.vmware.finra.data.LandingZoneKey;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;

/**
 * User: cblack
 */
public class ToolBox {

    public static Collection<PartitionResolver>[] hashKeys(List<PartitionResolver> list, int numBukets) {
        Collection<PartitionResolver>[] returnValue = new Collection[numBukets];

        for (PartitionResolver key : list) {
            int index = Math.abs(key.getRoutingObject(null).hashCode()) % numBukets;
            if (returnValue[index] == null) {
                returnValue[index] = new LinkedList<PartitionResolver>();
            }
            returnValue[index].add(key);
        }
        return returnValue;
    }

    public static Object getObjectFromPDX(Object obj) {
        if (obj != null && obj instanceof PdxInstance) {
            obj = ((PdxInstance) obj).getObject();
        }
        return obj;
    }
}
