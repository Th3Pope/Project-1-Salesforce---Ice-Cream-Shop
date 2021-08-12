public class ContactUsApexController {
    
    @AuraEnabled
    public static String createNewCase(String firstName, String lastName, String email, String subject, String message) {
                                                
                                                try {
                                                    Case newCase = new Case();
                                                    newCase.SuppliedName = firstName + ' ' + lastName;
                                                    newCase.SuppliedEmail = email;
                                                    newCase.Description = message;
                                                    newCase.Subject = subject;
                                                    newCase.Origin = 'Web';
                                                    insert newCase;
                                                } catch (DMLException e) {
                                                    if (e.getNumDml() > 0) {
                                                        return 'Error: ' + e.getDmlMessage(0);
                                                    }
                                                    return 'Unknown error; please try again.';
                                                }
                                                return 'Success';
                                            }
}