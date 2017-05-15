package th.co.pt.pcca.pccaservice.helper;

import java.util.ResourceBundle;

import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;



public class WebUtil {
	public static boolean IsStringEmpty(final String s) {
		// Null-safe, short-circuit evaluation.
		return s == null || s.trim().isEmpty();
	}
	public static HttpSession session() {
	    ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
	    return attr.getRequest().getSession(true); // true == allow create
	}
	public static String GetPropertyMessage(String file_name,String key)
	{
		ResourceBundle rb = ResourceBundle.getBundle(file_name);
		
		String result= rb.getString(key);
		return result;
	}
	public static String EmailUser()
	{
	
		return WebUtil.GetPropertyMessage("webconfigmsg", "email_user");
	}
	public static String EmailPassword()
	{
	
		return WebUtil.GetPropertyMessage("webconfigmsg", "email_password");
	}
}
