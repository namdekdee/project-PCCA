package th.co.pt.pcca.pccaapp.controller.member;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import th.co.pt.pcca.pccaapp.entities.member.WorkTimeCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeEmailMainObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.client.util.DateTime;
import com.google.api.services.calendar.CalendarScopes;
import com.google.api.services.calendar.model.*;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.util.List;
import java.io.File;
import java.io.FileInputStream;


@Controller
public class MemberTestController {

	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	 /** Application name. */
    private static final String APPLICATION_NAME =
        "Google Calendar API Java Quickstart";

    /** Directory to store user credentials for this application. */
//    private static final java.io.File DATA_STORE_DIR = new java.io.File(
//        System.getProperty("user.home"), ".credentials/calendar-java-quickstart2");
    
    private static final java.io.File DATA_STORE_DIR = new java.io.File(
            "/hris/project/hrisquatz/credentials/calendar-java-quickstart2");
 

    /** Global instance of the {@link FileDataStoreFactory}. */
    private static FileDataStoreFactory DATA_STORE_FACTORY;

    /** Global instance of the JSON factory. */
    private static final JsonFactory JSON_FACTORY =
        JacksonFactory.getDefaultInstance();

    /** Global instance of the HTTP transport. */
    private static HttpTransport HTTP_TRANSPORT;

    /** Global instance of the scopes required by this quickstart.
     *
     * If modifying these scopes, delete your previously saved credentials
     * at ~/.credentials/calendar-java-quickstart
     */
    private static final List<String> SCOPES =
        Arrays.asList(CalendarScopes.CALENDAR);

    static {
        try {
            HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
            DATA_STORE_FACTORY = new FileDataStoreFactory(DATA_STORE_DIR);
        } catch (Throwable t) {
            t.printStackTrace();
            System.exit(1);
        }
    }
    
    /**
     * Creates an authorized Credential object.
     * @return an authorized Credential object.
     * @throws IOException
     */
    public static Credential authorize() throws IOException {
        // Load client secrets.
       // InputStream in =  new FileInputStream(new File("D://google_authen//client_secret.json.json"));
    	//InputStream in = MemberTestController.class.getResourceAsStream("/client_secret.json");
    	InputStream in = MemberTestController.class.getClassLoader().getResourceAsStream("client_secret2.json");
    	if (in == null) {
			// Web Path
			in = Thread.currentThread().getContextClassLoader().getResourceAsStream("client_secret2.json");
		}
    	//new FileInputStream(new File("D://google_authen//client_secret.json.json"));
        //MemberTestController.class.getResourceAsStream("/client_secret.json");
        GoogleClientSecrets clientSecrets =
            GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));

        // Build flow and trigger user authorization request.
        GoogleAuthorizationCodeFlow flow =
                new GoogleAuthorizationCodeFlow.Builder(
                        HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                .setDataStoreFactory(DATA_STORE_FACTORY)
                .setAccessType("offline")
                .build();
        Credential credential = new AuthorizationCodeInstalledApp(
            flow, new LocalServerReceiver()).authorize("user");
        System.out.println(
                "Credentials saved to " + DATA_STORE_DIR.getAbsolutePath());
        return credential;
    }

    /**
     * Build and return an authorized Calendar client service.
     * @return an authorized Calendar client service
     * @throws IOException
     */
    public static com.google.api.services.calendar.Calendar
        getCalendarService() throws IOException {
        Credential credential = authorize();
        return new com.google.api.services.calendar.Calendar.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, credential)
                .setApplicationName(APPLICATION_NAME)
                .build();
    }

	@RequestMapping(value = "/member-test23", method = RequestMethod.GET)
	public void memberhistory()
	{
		try
		{
			// TODO Auto-generated method stub
			final String username = "testaek176@gmail.com";
			final String password = "AdminTest123";
			
			//sent mail array Recipient 
			//String[] arrMail = {"somjeep24@gmail.com","yupin.su@pt.co.th","yupin.suk24@gmail.com"};
			
			Properties props = new Properties();
			props.put("mail.smtp.auth","true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port","587");
			
			
			
			Session session = Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication(){
					return new PasswordAuthentication(username, password);
				}
			});
			try{
				//sent mail array Recipient 
				/*for(int i = 0;i < arrMail.length;i++){
					Message message = new MimeMessage(session);
					message.setFrom(new InternetAddress("from-email@gmail.com"));
					message.addRecipient(Message.RecipientType.TO, 
							new InternetAddress(arrMail[i]));
					message.setSubject("Testing Subject");
					message.setText("Dear Mail Crawler,"
						+ "\n\n No spam to my email, please!");
					Transport.send(message);
				}*/
				Message message = new MimeMessage(session);
				message.setFrom(new InternetAddress("testaek176@gmail.com"));
				//sent mail to me
				/*message.setRecipients(Message.RecipientType.TO, 
						InternetAddress.parse("to-yupin.su@pt.co.th"));*/
				
				//sent mail to other
				message.addRecipient(Message.RecipientType.TO, 
						new InternetAddress("testaek176@gmail.com"));
				message.setSubject("Testing Subject");
				message.setText("Dear Mail Crawler,"
					+ "\n\n No spam to my email, please!");
				Transport.send(message);
				
				
				
				System.out.println("Done");
			}catch(MessagingException e){
				logger.error(e.getMessage(),e);
				throw new RuntimeException(e);
				
			}
            			
		}
		catch(Exception ex)
		{}
		
	}
	@RequestMapping(value = "/member-test", method = RequestMethod.GET)
	public void MemberTestCalendar()
	{
		try
		{
		// Build a new authorized API client service.
        // Note: Do not confuse this class with the
        //   com.google.api.services.calendar.model.Calendar class.
        com.google.api.services.calendar.Calendar service =
            getCalendarService();

        // List the next 10 events from the primary calendar.
        /*DateTime now = new DateTime(System.currentTimeMillis());
        Events events = service.events().list("primary")
            .setMaxResults(10)
            .setTimeMin(now)
            .setOrderBy("startTime")
            .setSingleEvents(true)
            .execute();
        List<Event> items = events.getItems();
        if (items.size() == 0) {
            System.out.println("No upcoming events found.");
        } else {
            System.out.println("Upcoming events");
            for (Event event : items) {
                DateTime start = event.getStart().getDateTime();
                if (start == null) {
                    start = event.getStart().getDate();
                }
                System.out.printf("%s (%s)\n", event.getSummary(), start);
            }
        }
        */
        
        Event event = new Event()
	    //.setSummary("Meeting 2016")
		.setSummary("ทดลองการประชุม 2016")
	    .setLocation("Cyber world tower")
	    .setDescription("ทดลองภาษาไทย");

	    //.setDescription("A chance to hear more about Google's developer products.");
		
		//System.out.println("event: "+event.getDescription());

		DateTime startDateTime = new DateTime("2016-12-07T13:30:00+07:00");
		//System.out.println("startDateTime: "+startDateTime);
		EventDateTime start = new EventDateTime()
		    .setDateTime(startDateTime)
		    .setTimeZone("Asia/Bangkok");
		event.setStart(start);
		//System.out.println("start: "+start.getDateTime());
		
	
		DateTime endDateTime = new DateTime("2016-12-07T14:00:00+07:00");
		EventDateTime end = new EventDateTime()
		    .setDateTime(endDateTime)
		    .setTimeZone("Asia/Bangkok");
		event.setEnd(end);
	
		/*String[] recurrence = new String[] {"RRULE:FREQ=DAILY;COUNT=2"};
		event.setRecurrence(Arrays.asList(recurrence));*/
	
		EventAttendee[] attendees = new EventAttendee[] {
				 new EventAttendee().setEmail("ptg.hris@pt.co.th"),
			     //new EventAttendee().setEmail("utain.on@pt.co.th"),
		};
		event.setAttendees(Arrays.asList(attendees));
		//System.out.println("Email: "+event.getAttendees());
	
		EventReminder[] reminderOverrides = new EventReminder[] {
		    new EventReminder().setMethod("email").setMinutes(10),
		    new EventReminder().setMethod("popup").setMinutes(10),
		    new EventReminder().setMethod("sms").setMinutes(10),
		    
		};
		Event.Reminders reminders = new Event.Reminders()
		    .setUseDefault(false)
		    .setOverrides(Arrays.asList(reminderOverrides));
		event.setReminders(reminders);
		//System.out.println("reminers: "+event.getReminders());
		
		//System.out.println("55555");
		event = service.events().insert("primary", event).execute();
		System.out.printf("Event created: %s\n", event.getHtmlLink());
		}
		catch(Exception ex){
			logger.error(ex.getMessage(),ex);
		}
	
	}
	
	@RequestMapping(value = "/member-getedittime-request", method = RequestMethod.GET)
	public @ResponseBody List<WorkTimeEmailMainObj> GetWorkTime() {
		
		String uri = WebUtil.WebServiceUrl() + "HrisService/member-getedittime-request";
		RestTemplate restTemplate = new RestTemplate();
		List<WorkTimeEmailMainObj> result = restTemplate.postForObject(uri, null,List.class);
		return result;
	}
	
}
