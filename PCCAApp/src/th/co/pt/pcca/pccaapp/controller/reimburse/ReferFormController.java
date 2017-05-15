package th.co.pt.pcca.pccaapp.controller.reimburse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReferFormController {
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/referForm", method=RequestMethod.GET)
	public ModelAndView cahistory(){
		return new ModelAndView("referForm", null);
	}

}
