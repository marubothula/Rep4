global class schUpdateAccphon implements Schedulable {
    global void execute(SchedulableContext ctx) {
    
        UpdateAccphon par = new UpdateAccphon();
        database.executeBatch(par);
    }
}