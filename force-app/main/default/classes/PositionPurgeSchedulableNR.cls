public class PositionPurgeSchedulableNR implements Schedulable {    
    public void execute(SchedulableContext sc){    
        PositionPurgeBatchNR b = new PositionPurgeBatchNR();
        database.executeBatch(b);
    }
}