package th.co.pt.pcca.pccaservice.controller.unittest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UnitTestController {

	@RequestMapping(value = "/unittest-home", method = RequestMethod.GET)
	public ModelAndView index() {

		return new ModelAndView("home_default", null);
	}
	
	@RequestMapping(value = "/unittest-workflow", method = RequestMethod.GET)
	public ModelAndView UnittestWorkflow() {

		return new ModelAndView("unittest_workflow", null);
	}
}
