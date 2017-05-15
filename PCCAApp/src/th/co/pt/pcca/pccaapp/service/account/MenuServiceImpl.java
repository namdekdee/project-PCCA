package th.co.pt.pcca.pccaapp.service.account; 

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

import th.co.pt.pcca.pccaapp.classobject.CGlobal;
import th.co.pt.pcca.pccaapp.controller.member.MemberApproveEditTimeController;
import th.co.pt.pcca.pccaapp.entities.account.MainMenuObj;
import th.co.pt.pcca.pccaapp.entities.account.UserMenuObj;
import th.co.pt.pcca.pccaapp.entities.member.MemberObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeCriteriaObj;
import th.co.pt.pcca.pccaapp.entities.member.WorkTimeObj;
import th.co.pt.pcca.pccaapp.helper.WebUtil;
@Repository("menuService")
public class MenuServiceImpl implements MenuService {
	private List<WorkTimeObj> resultApproveEditTime = null;
	private List<WorkTimeObj> resultApproveLeave = null;
	private List<WorkTimeObj> resultApproveWorkOut = null;
	private List<WorkTimeObj> resultApproveOT = null;
	private int approveSummary = 0;
	
	public UserMenuObj GetMenu(String strPage,HttpSession session) {
		  UserMenuObj result = new UserMenuObj();
		  
		  //Permiss Page validation
          int check = 0;
          if (CGlobal.getC_UserInfo(session).mainmenu != null)
          {
        	  this.approveSummary = 0;
        	  WorkTimeCriteriaObj criteria = new WorkTimeCriteriaObj();
    		  criteria.setApprover(CGlobal.getC_UserInfo(session).codempid);
    		  criteria.setStatus("11");
    		  String uri1 = WebUtil.WebServiceUrl() + "HrisService/member-getworktime-edittime-approve";
    		  String uri2 = WebUtil.WebServiceUrl() + "HrisService/member-getworktime-leave-approve";
    		  String uri3 = WebUtil.WebServiceUrl() + "HrisService/member-getworkout-approve";
    		  String uri4 = WebUtil.WebServiceUrl() + "HrisService/member-getworktime-ot-approve";
    		  RestTemplate restTemplate = new RestTemplate();
    		  this.resultApproveEditTime = restTemplate.postForObject(uri1, criteria,List.class);
    		  this.resultApproveLeave = restTemplate.postForObject(uri2, criteria, List.class);
    		  this.resultApproveWorkOut = restTemplate.postForObject(uri3, criteria, List.class);
    		  this.resultApproveOT = restTemplate.postForObject(uri4, criteria, List.class);
    		  this.approveSummary = approveSummary+resultApproveEditTime.size()+resultApproveLeave.size()+resultApproveWorkOut.size()+resultApproveOT.size();
    		  
        	  MemberObj member_info =CGlobal.getC_UserInfo(session);
        	  
              result.codempid = member_info.codempid;
              result.lang = member_info.lang;
              //Language thai
              if(WebUtil.IsStringEmpty(member_info.lang))
              {
            	  member_info.lang ="th";
              }
              if (member_info.lang.equals("th"))
              {
                  result.profile = "ประวัติพนักงาน";
                  result.signout = "ออกจากระบบ";
                  result.name = member_info.namempt ;
                  result.nameright = member_info.namempt ;
                  result.nameposition = member_info.namempt +" - " + member_info.nampost;
                  result.since = "เป็นสมาชิกตั้งแต่ " + member_info.dteempmt;
                  String gen_div = "";
                  String app_id = "";
                  String site_map = "";
                  String site_child = "";
                  member_info.sitemap = new ArrayList<MainMenuObj>();
                  //Check permiss path
                  for(int i=0;i<member_info.mainmenu.size();i++)
                  {
                	  if(!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_path)){
                	  if(member_info.mainmenu.get(i).app_path.equals(strPage))
                	  {
                		  app_id = member_info.mainmenu.get(i).app_parent;
                		  //site_map = "<section class='content-header'><h1>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "<small>" + CGlobal.C_UserInfo.mainmenu.get(i).app_head_desc + "</small></h1>";
                		  site_map = "<section class='content-header'><h1>" + member_info.mainmenu.get(i).app_desc +"</h1>";
                          site_child = "<li class='active'>" + member_info.mainmenu.get(i).app_desc + "</li>";
                          member_info.sitemap.add(member_info.mainmenu.get(i));
                          member_info.title = "Hris | " + member_info.mainmenu.get(i).app_desc;
                          result.title ="Hris | " + member_info.mainmenu.get(i).app_desc;
                          check++;
                          i=member_info.mainmenu.size();
                	  }
                	  }
                  }
                  if (!WebUtil.IsStringEmpty(site_map))
                  {
                      site_map += "<ol class='breadcrumb'><li><a href='home'><i class='fa fa-dashboard'></i> หน้าแรก</a></li>";

                      Boolean b_site = true;
                      while (b_site)
                      {
                    	  for(int i=0;i<member_info.mainmenu.size();i++)
                    	  {	  
                    		  b_site = false;
                    		  if(!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_id)){
                    		  if(member_info.mainmenu.get(i).app_id.equals(app_id) )
                    		  {
                    			  app_id = member_info.mainmenu.get(i).app_parent;
                                  site_child = "<li>" + member_info.mainmenu.get(i).app_desc + "</li>" + site_child;
                                  member_info.sitemap.add(member_info.mainmenu.get(i));
                                  b_site = true;  
                    		  }
                    	  }
                    	  }
                          
                      }
                      site_map += site_child + "</ol></section>";


                      result.sitemap = site_map;
                  }
                  gen_div = gen_div+ "<ul class='sidebar-menu'><li class='header'>MAIN NAVIGATION</li>";
                  for (int i = 0; i < member_info.mainmenu.size(); i++)
                  {
                	  if(WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_parent))
                	  {
                		  String img = "";
                          if (!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_img))
                          {
                              img = member_info.mainmenu.get(i).app_img;
                          }

                          String li_child = "";
                          //set Data Back
                          CGlobal.setC_UserInfo(member_info, session);
                        	  if (!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_id))
                              {
                        		  li_child = this.GetChild(member_info.mainmenu.get(i).app_id,session);
                        		  if (!WebUtil.IsStringEmpty(li_child))
                                  {
                        			 
                        			  if (this.IsActive(member_info.mainmenu.get(i),session))
                                      {
                                          gen_div += " <li class='active treeview'> "; 
                                          gen_div += " <a href='#'> "; 
                                          gen_div += " <i class='glyphicon glyphicon-" + img + "'></i> " ;
                                          gen_div += "<span>" + member_info.mainmenu.get(i).app_desc + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += " <i class='fa fa-angle-left pull-right'></i></span> ";
                                          if(member_info.mainmenu.get(i).app_path.equals("tt")) {
                                        	  gen_div += "&nbsp;<span class='label custom-label-primary'>"+this.approveSummary+"</span>";
                                          }
                                          gen_div += "</a> ";
                                          gen_div += "<ul class='treeview-menu'>";
                                          gen_div += li_child;
                                          gen_div += " </ul></li>";
                                      }
                                      else
                                      {
                                          gen_div += " <li class='treeview'> ";
                                          gen_div += "<a href='#'> ";
                                          gen_div += "<i class='glyphicon glyphicon-" + img + "'></i> " ;
                                          gen_div += " <span>" + member_info.mainmenu.get(i).app_desc + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += "  <i class='fa fa-angle-left pull-right'></i></span> ";
                                          if(member_info.mainmenu.get(i).app_path.equals("tt")) {
                                        	  gen_div += "&nbsp;<span class='label custom-label-primary'>"+this.approveSummary;
                                          }
                                          gen_div += " </span></a> ";
                                          gen_div += "<ul class='treeview-menu'>";
                                          gen_div += li_child;

                                          gen_div += " </ul></li>";
                                      }
                                  }
                        		  else
                                  {
                                      if (this.IsActive(member_info.mainmenu.get(i),session))
                                      {
                                    	  img = member_info.mainmenu.get(i).app_img;
                                          gen_div += " <li class='active'> <a href='" + member_info.mainmenu.get(i).app_path + "'> " ;
                                          gen_div += " <i class='glyphicon glyphicon-"+img+"'></i><span>" + member_info.mainmenu.get(i).app_desc + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += " </span> ";
                                          gen_div += " </a> ";
                                          gen_div += "</li> ";
                                      }
                                      else
                                      {
                                    	  img = member_info.mainmenu.get(i).app_img;
                                          gen_div += " <li> <a href='" + member_info.mainmenu.get(i).app_path + "'> " ;
                                          gen_div += " <i class='glyphicon glyphicon-"+img+"'></i><span>" + member_info.mainmenu.get(i).app_desc + "</span> " ;
                                          gen_div += " <span class='pull-right-container'> ";
                                          gen_div += " </span> ";
                                          gen_div += " </a> ";
                                          gen_div += " </li>";
                                      }
                                  }
                              }
                          }

                	  
                	  
                   }
                  
                  gen_div += " </ul>";
                  result.menu = gen_div;
                  result.success = 1;
              }
              //English Language
              else
              {
                  result.profile = "Profile";
                  result.signout = "Sign out";
                  result.name = member_info.namempe ;
                  result.nameright = member_info.namempe ;
                  result.nameposition = member_info.namempe + " - " + member_info.nampose;
                  result.since = "Member since " + member_info.dteempmt;
                  String gen_div = "";
                  String app_id = "";
                  String site_map = "";
                  String site_child = "";
                  member_info.sitemap = new ArrayList<MainMenuObj>();
                  //Check permiss path
                  for(int i=0;i<member_info.mainmenu.size();i++)
                  {
                	  if(!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_path)){
                	  if(member_info.mainmenu.get(i).app_path.equals(strPage))
                	  {
                		  app_id = member_info.mainmenu.get(i).app_parent;
                		  //site_map = "<section class='content-header'><h1>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "<small>" + CGlobal.C_UserInfo.mainmenu.get(i).app_head_desc_en + "</small></h1>";
                		  site_map = "<section class='content-header'><h1>" + member_info.mainmenu.get(i).app_desc_en + "</h1>";
                          site_child = "<li class='active'>" + member_info.mainmenu.get(i).app_desc_en + "</li>";
                          member_info.sitemap.add(member_info.mainmenu.get(i));
                          member_info.title = "Hris | " + member_info.mainmenu.get(i).app_desc_en;
                          result.title ="Hris | " + member_info.mainmenu.get(i).app_desc_en;
                          check++;
                          i=member_info.mainmenu.size();
                	  }
                	  }
                  }
                  if (!WebUtil.IsStringEmpty(site_map))
                  {
                      site_map += "<ol class='breadcrumb'><li><a href='home'><i class='fa fa-dashboard'></i> Home</a></li>";

                      Boolean b_site = true;
                      while (b_site)
                      {
                    	  for(int i=0;i<member_info.mainmenu.size();i++)
                    	  {	  
                    		  b_site = false;
                    		  if(!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_id)){
                    		  if(member_info.mainmenu.get(i).app_id.equals(app_id) )
                    		  {
                    			  app_id = member_info.mainmenu.get(i).app_parent;
                                  site_child = "<li>" + member_info.mainmenu.get(i).app_desc_en + "</li>" + site_child;
                                  member_info.sitemap.add(member_info.mainmenu.get(i));
                                  b_site = true;  
                    		  }
                    	  }
                    	  }
                          
                      }
                      site_map += site_child + "</ol></section>";


                      result.sitemap = site_map;
                  }
                  gen_div = gen_div+ "<ul class='sidebar-menu'><li class='header'>MAIN NAVIGATION</li>";
                  for (int i = 0; i < member_info.mainmenu.size(); i++)
                  {
                	  if(WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_parent))
                	  {
                		  String img = "";
                          if (!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_img))
                          {
                              img = member_info.mainmenu.get(i).app_img;
                          }

                          String li_child = "";
                          //set Data Back
                          CGlobal.setC_UserInfo(member_info, session);
                        	  if (!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_id))
                              {
                        		  li_child = this.GetChild(member_info.mainmenu.get(i).app_id,session);
                        		  if (!WebUtil.IsStringEmpty(li_child))
                                  {
                        			  if (this.IsActive(member_info.mainmenu.get(i),session))
                                      {
                                          gen_div += " <li class='active treeview'> ";
                                          gen_div += " <a href='#'> "; 
                                          gen_div += " <i class='glyphicon glyphicon-" + img + "'></i> " ;
                                          gen_div += "<span>" + member_info.mainmenu.get(i).app_desc_en + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += " <i class='fa fa-angle-left pull-right'></i></span> ";
                                          gen_div += "&nbsp;<span id='memberapprovesummary' class='label label-primary'>0";
                                          gen_div += " </span></a> ";
                                          gen_div += "<ul class='treeview-menu'>";
                                          gen_div += li_child;
                                          gen_div += " </ul></li>";
                                      }
                                      else
                                      {
                                          gen_div += " <li class='treeview'> ";
                                          gen_div += "<a href='#'> ";
                                          gen_div += "<i class='glyphicon glyphicon-" + img + "'></i> " ;
                                          gen_div += " <span>" + member_info.mainmenu.get(i).app_desc_en + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += "  <i class='fa fa-angle-left pull-right'></i></span> ";
                                          gen_div += "&nbsp;<span id='memberapprovesummary' class='label label-primary'>0";
                                          gen_div += " </span></a> ";
                                          gen_div += "<ul class='treeview-menu'>";
                                          gen_div += li_child;

                                          gen_div += " </ul></li>";
                                      }
                                  }
                        		  else
                                  {
                                      if (this.IsActive(member_info.mainmenu.get(i),session))
                                      {
                                    	  img = member_info.mainmenu.get(i).app_img;
                                          gen_div += " <li class='active'> <a href='" + member_info.mainmenu.get(i).app_path + "'> " ;
                                          gen_div += " <i class='glyphicon glyphicon-"+img+"'></i><span>" + member_info.mainmenu.get(i).app_desc_en + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += " </span> ";
                                          gen_div += " </a> ";
                                          gen_div += "</li> ";
                                      }
                                      else
                                      {
                                    	  img = member_info.mainmenu.get(i).app_img;
                                          gen_div += " <li> <a href='" + member_info.mainmenu.get(i).app_path + "'> " ;
                                          gen_div += " <i class='glyphicon glyphicon-"+img+"'></i><span>" + member_info.mainmenu.get(i).app_desc_en + "</span> " ;
                                          gen_div += " <span class='pull-right-container'> ";
                                          gen_div += " </span> ";
                                          gen_div += " </a> ";
                                          gen_div += " </li>";
                                      }
                                  }
                              }
                          }

                	  
                	  
                   } 
                  
                  gen_div += " </ul>";
                  result.menu = gen_div;
                  result.success = 1;
              
              }
              CGlobal.setC_UserInfo(member_info, session);
          }
		  return  result;
	}
	private String GetChild(String appid,HttpSession session)					//edit here
      {
		  
		  MemberObj member_info = CGlobal.getC_UserInfo(session);
          if (member_info.lang.equals("th"))
          {
              String li = "";
              for(int i =0; i< member_info.mainmenu.size();i++)
              {
            	  if(!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_parent)){
            	  if(member_info.mainmenu.get(i).app_parent.equals(appid) )
            	  {
                          String img = "";
                          if (!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_img))
                          {
                              img = member_info.mainmenu.get(i).app_img;
                          }
                          String li_child = this.GetChild(member_info.mainmenu.get(i).app_id,session);

                          if (!WebUtil.IsStringEmpty(li_child))
                          {
                        	  
                              if (this.IsActive(member_info.mainmenu.get(i),session))
                              {
                                  li += " <li class='active'> ";
                                  li += " <a href='#'> ";
                                  li += " <i class='fa fa-circle-o'></i> " ;
                                  li += " <span>" + member_info.mainmenu.get(i).app_desc + "</span> " ;
                                  li += " <span class='pull-right-container'> ";
                                  li += " <i class='fa fa-angle-left pull-right'></i> ";
                                  li += " </span></a> ";
                                  li += " <ul class='treeview-menu'>";
                                  li += li_child;

                                  li += " </ul></li>";
                              }
                              else
                              {
                                  li += " <li> ";
                                  li +=" <a href='#'> ";
                                  li +=" <i class='fa fa-circle-o'></i> " ;
                                  li +=" <span>" + member_info.mainmenu.get(i).app_desc + "</span> " ;
                                  li +="  <span class='pull-right-container'> ";
                                  li +="  <i class='fa fa-angle-left pull-right'></i> ";
                                  li += " </span></a> ";
                                  li += "<ul class='treeview-menu'>";
                                  li += li_child;

                                  li += " </ul></li>";
                              }
                          }
                          else
                          {
                        	  //String id = member_info.mainmenu.get(i).app_path.replaceAll("-", "");
                        	  String path = member_info.mainmenu.get(i).app_path;
                        	  int number = this.getNumber(path);
                              if (this.IsActive(member_info.mainmenu.get(i),session))
                              {
                                  li += " <li class='active'> <a href='" + member_info.mainmenu.get(i).app_path + "'> ";
                                  li += " <i class='glyphicon glyphicon-chevron-right'></i><span class='custom-font-label-medium'>" + member_info.mainmenu.get(i).app_desc + "</span>";
                                    
                                  if(number<100)li += "&nbsp;<span class='label custom-label-primary' style='display:"+(number==0 ? "none":"inline")+";'>"+number+"</span></a></li>";
                                  else li += "&nbsp;<span class='label custom-label-primary padding-3' style='display:block;'>99+</span></a></li>";
                              }
                              else
                              {
                                  li += " <li> <a href='" + member_info.mainmenu.get(i).app_path + "'> " ;
                                  li += " <i class='glyphicon glyphicon-chevron-right'></i><span class='custom-font-label-medium'>" + member_info.mainmenu.get(i).app_desc + "</span>";
                                 
                                  if(number<100) li += "&nbsp;<span class='label custom-label-primary' style='display:"+(number==0 ? "none":"inline")+";'>"+number+"</span></a></li>";
                                  else li += "&nbsp;<span class='label custom-label-primary padding-3' style='display:block;'>99+</span></a></li>";
                              }
                          }

                      }
            	  }

              
              }
           
              return li;
          }
          else
          {
              String li = "";
              for(int i =0; i< member_info.mainmenu.size();i++)
              {
            	  if(!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_parent)){
            	  if(member_info.mainmenu.get(i).app_parent.equals(appid) )
            	  {
                          String img = "";
                          if (!WebUtil.IsStringEmpty(member_info.mainmenu.get(i).app_img))
                          {
                              img = member_info.mainmenu.get(i).app_img;
                          }
                          String li_child = this.GetChild(member_info.mainmenu.get(i).app_id,session);

                          if (!WebUtil.IsStringEmpty(li_child))
                          {

                              if (this.IsActive(member_info.mainmenu.get(i),session))
                              {
                                  li += " <li class='active'> ";
                                  li += " <a href='#'> ";
                                  li += " <i class='fa fa-circle-o'></i> " ;
                                  li += " <span>" + member_info.mainmenu.get(i).app_desc_en + "</span> " ;
                                  li += " <span class='pull-right-container'> ";
                                  li += " <i class='fa fa-angle-left pull-right'></i> ";
                                  li += " </span></a> ";
                                  li += " <ul class='treeview-menu'>";
                                  li += li_child;

                                  li += " </ul></li>";
                              }
                              else
                              {
                                  li += " <li> ";
                                  li +=" <a href='#'> ";
                                  li +=" <i class='fa fa-circle-o'></i> " ;
                                  li +=" <span>" + member_info.mainmenu.get(i).app_desc_en + "</span> " ;
                                  li +="  <span class='pull-right-container'> ";
                                  li +="  <i class='fa fa-angle-left pull-right'></i> ";
                                  li += " </span></a> ";
                                  li += "<ul class='treeview-menu'>";
                                  li += li_child;

                                  li += " </ul></li>";
                              }
                          }
                          else
                          {
                        	  String path = member_info.mainmenu.get(i).app_path;
                        	  int number = this.getNumber(path);
                              if (this.IsActive(member_info.mainmenu.get(i),session))
                              {
                                  li += " <li class='active'> <a href='" + member_info.mainmenu.get(i).app_path + "'> ";
                                  li += " <i class='glyphicon glyphicon-chevron-right'></i><span class='custom-font-label-medium'>" + member_info.mainmenu.get(i).app_desc_en + "</span>";
                                  
                                  if(number<100) li += "&nbsp;<span class='label custom-label-primary' style='display:"+(number==0 ? "none":"block")+"'>"+number+"</span></a></li>";
                                  else li += "&nbsp;<span class='label custom-label-primary padding-3' style='display:block'>99+</span></a></li>";
                              }
                              else
                              {
                                  li += " <li> <a href='" + member_info.mainmenu.get(i).app_path + "'> " ;
                                  li += " <i class='glyphicon glyphicon-chevron-right'></i><span class='custom-font-label-medium'>" + member_info.mainmenu.get(i).app_desc_en + "</span>";
                                  
                                  if(number<100) li += "&nbsp;<span class='label custom-label-primary' style='display:"+(number==0 ? "none":"block")+"'>"+number+"</span></a></li>";
                                  else li += "&nbsp;<span class='label custom-label-primary padding-3' style='display:block'>99+</span></a></li>";
                              }
                          }

                      }
            	  }

              
              }
           
              return li;
          }
      }
	
	 private Boolean IsActive(MainMenuObj main_menu,HttpSession session)
     {
		 MemberObj member_info = CGlobal.getC_UserInfo(session);
		 Boolean ref_check = false;
         for(int i=0;i<member_info.sitemap.size();i++)
         {
        	 if(!WebUtil.IsStringEmpty(member_info.sitemap.get(i).app_id)){
        	 if(member_info.sitemap.get(i).app_id.equals(main_menu.app_id) )
        	 {
        		 i= member_info.sitemap.size();
        		 member_info.addp =main_menu.addp;
        		 member_info.savep =main_menu.savep;
        		 member_info.deletep =main_menu.deletep;
        		 member_info.approve_flg =main_menu.approve_flg;
        		 member_info.editp =main_menu.editp;
        		 member_info.head_flg =main_menu.head_flg;
        		 ref_check = true;
        		 CGlobal.setC_UserInfo(member_info, session);
        	 }
        	 }
         }
         
         return ref_check;
     }
	 
	 
	 private int getNumber(String id) {
		 int number = 0;
		 if(id.equals("member-approve-edittime")) {
			 number = this.resultApproveEditTime.size();
		 } else if(id.equals("member-approve-leave")) {
			 number = this.resultApproveLeave.size();
		 } else if(id.equals("member-approve-workout")) {
			 number = this.resultApproveWorkOut.size();
		 } else if(id.equals("member-approve-ot")) {
			 number = this.resultApproveOT.size();
		 }
		 
		 return number;
	 }
}
