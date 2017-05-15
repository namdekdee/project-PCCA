package th.co.pt.pcca.pccaservice.helper;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import th.co.pt.pcca.pccaservice.entities.util.MailObj;


public class MailUtil {

	public static boolean SendMail(MailObj obj){
		final String username = obj.getEmail();
		final String password = obj.getPassword();
		
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
			message.setFrom(new InternetAddress(username));
			//sent mail to me
			/*message.setRecipients(Message.RecipientType.TO, 
					InternetAddress.parse("to-yupin.su@pt.co.th"));*/
			
			//sent mail to other
			message.addRecipient(Message.RecipientType.TO, 
					new InternetAddress(obj.getEmail_to()));
			message.setSubject(obj.getSubject());
			
			message.setContent(obj.getBody(), "text/html;charset=UTF-8");
			Transport.send(message);
			return true;
		}catch(MessagingException e){

			throw new RuntimeException(e);
			
		}
		
	}
}
