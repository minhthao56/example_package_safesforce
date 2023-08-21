
@isTest
public with sharing class TriggerAfterCreateContactTest {
    @isTest
    public static void CreateContactSuccessfully() {
        String firstName = generateRandomString(10);
        String lastName = generateRandomString(10);
        String email = generateRandomString(10) + '@test.com';
        String department = 'IT';


        Contact contact = new Contact();
        contact.FirstName = firstName;
        contact.LastName = lastName;
        contact.Email = email;
        contact.Department = department;
        insert contact;
        
        List<Contact> contacts = [SELECT Id, Email, LastName,FirstName, Department FROM Contact];
        assert.areEqual(1, contacts.size(), 'We expected one contact record to be created');
        Contact contactFirst = contacts.get(0);
        assert.areEqual(firstName, contactFirst.FirstName, 'We expected the first name to be ' + firstName);
        assert.areEqual(lastName, contactFirst.LastName, 'We expected the last name to be ' + lastName);
        assert.areEqual(email.toLowerCase(), contactFirst.Email.toLowerCase(), 'We expected the email to be ' + email);
        assert.areEqual(department, contactFirst.Department, 'We expected the department to be ' + department);
        // print out the contact id
        System.debug('Contact Id: ' + contactFirst.Id);
    }

    private static String generateRandomString(Integer length) {
        String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < length) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        return randStr;
    }
}