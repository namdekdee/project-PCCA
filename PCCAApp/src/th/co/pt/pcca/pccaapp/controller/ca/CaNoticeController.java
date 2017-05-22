package th.co.pt.pcca.pccaapp.controller.ca;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class CaNoticeController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/ca_notice", method = RequestMethod.GET)
	public ModelAndView cahistory() {
		return new ModelAndView("ca_notice", null);
	}
}
