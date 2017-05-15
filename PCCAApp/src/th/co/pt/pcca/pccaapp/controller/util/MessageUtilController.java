package th.co.pt.pcca.pccaapp.controller.util;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import th.co.pt.pcca.pccaapp.entities.member.MemberObj;
import th.co.pt.pcca.pccaapp.entities.util.MessageObj;
import th.co.pt.pcca.pccaapp.entities.util.ResultObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;

@Controller
public class MessageUtilController {
	
	@RequestMapping(value = "/util-getmsg", method = RequestMethod.POST)
	public @ResponseBody MessageObj login(@RequestBody MessageObj msg) {
		MessageObj result = new MessageObj();
		result.message_id=msg.message_id;
		result.message_desc =WebUtil.GetPropertyMessage("commonmsg", msg.message_id);
		return result;
	}
}
