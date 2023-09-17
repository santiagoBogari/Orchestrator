public class einstein_class {
    
    public static List<Incident> getIncidentRecords() {
        List<Incident> incidentList = [SELECT Id, Status,Subject  FROM Incident];
        return incidentList;
    }
}