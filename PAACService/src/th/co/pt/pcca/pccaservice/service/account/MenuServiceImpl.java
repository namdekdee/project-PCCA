package th.co.pt.pcca.pccaservice.service.account;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import th.co.pt.pcca.pccaservice.classobject.CGlobal;
import th.co.pt.pcca.pccaservice.dao.account.MenuDao;
import th.co.pt.pcca.pccaservice.entities.account.MainMenuObj;
import th.co.pt.pcca.pccaservice.entities.account.UserMenuObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;
import th.co.pt.pcca.pccaservice.helper.WebUtil;
@Repository("menuService")
public class MenuServiceImpl implements MenuService {

	public UserMenuObj GetMenu(String strPage) {
		  UserMenuObj result = new UserMenuObj();
		  //Permiss Page validation
          int check = 0;
          if (CGlobal.C_UserInfo.mainmenu != null)
          {
              result.memberno = CGlobal.C_UserInfo.codempid;
              result.lang = CGlobal.C_UserInfo.lang;
              //Language thai
              if (CGlobal.C_UserInfo.lang.equals("th"))
              {
                  result.profile = "ข้อมูลส่วนตัว";
                  result.signout = "ออกจากระบบ";
                  result.name = CGlobal.C_UserInfo.namempt ;
                  result.nameright = CGlobal.C_UserInfo.namempt ;
                 // result.nameposition = CGlobal.C_UserInfo.name + " " + CGlobal.C_UserInfo.surname + " - " + CGlobal.C_UserInfo.position_desc;
                  result.since = "เป็นสมาชิกตั้งแต่ " + CGlobal.C_UserInfo.since_date;
                  String gen_div = "";
                  String app_id = "";
                  String site_map = "";
                  String site_child = "";
                  CGlobal.C_UserInfo.sitemap = new ArrayList<MainMenuObj>();
                  //Check permiss path
                  for(int i=0;i<CGlobal.C_UserInfo.mainmenu.size();i++)
                  {
                	  if(!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_path)){
                	  if(CGlobal.C_UserInfo.mainmenu.get(i).app_path.equals(strPage))
                	  {
                		  app_id = CGlobal.C_UserInfo.mainmenu.get(i).app_parent;
                		  site_map = "<section class='content-header'><h1>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "<small>" + CGlobal.C_UserInfo.mainmenu.get(i).app_head_desc + "</small></h1>";
                          site_child = "<li class='active'>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "</li>";
                          CGlobal.C_UserInfo.sitemap.add(CGlobal.C_UserInfo.mainmenu.get(i));
                          CGlobal.C_UserInfo.title = "Hris | " + CGlobal.C_UserInfo.mainmenu.get(i).app_desc;
                          check++;
                          i=CGlobal.C_UserInfo.mainmenu.size();
                	  }
                	  }
                  }
                  if (!WebUtil.IsStringEmpty(site_map))
                  {
                      site_map += "<ol class='breadcrumb'><li><a href='home'><i class='fa fa-dashboard'></i> เธซเธ?เน?เธฒเน?เธฃเธ?</a></li>";

                      Boolean b_site = true;
                      while (b_site)
                      {
                    	  for(int i=0;i<CGlobal.C_UserInfo.mainmenu.size();i++)
                    	  {	  
                    		  b_site = false;
                    		  if(!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_id)){
                    		  if(CGlobal.C_UserInfo.mainmenu.get(i).app_id.equals(app_id) )
                    		  {
                    			  app_id = CGlobal.C_UserInfo.mainmenu.get(i).app_parent;
                                  site_child = "<li>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "</li>" + site_child;
                                  CGlobal.C_UserInfo.sitemap.add(CGlobal.C_UserInfo.mainmenu.get(i));
                                  b_site = true;  
                    		  }
                    	  }
                    	  }
                          
                      }
                      site_map += site_child + "</ol></section>";


                      result.sitemap = site_map;
                  }
                  gen_div = gen_div+ "<ul class='sidebar-menu'><li class='header'>MAIN NAVIGATION</li>";
                  for (int i = 0; i < CGlobal.C_UserInfo.mainmenu.size(); i++)
                  {
                	  if(WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_parent))
                	  {
                		  String img = "";
                          if (!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_img))
                          {
                              img = CGlobal.C_UserInfo.mainmenu.get(i).app_img;
                          }

                          String li_child = "";
                        
                        	  if (!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_id))
                              {
                        		  li_child = this.GetChild(CGlobal.C_UserInfo.mainmenu.get(i).app_id);
                        		  if (!WebUtil.IsStringEmpty(li_child))
                                  {
                        			  if (this.IsActive(CGlobal.C_UserInfo.mainmenu.get(i)))
                                      {
                                          gen_div += " <li class='active treeview'> ";
                                          gen_div += " <a href='#'> "; 
                                          gen_div += " <i class='" + img + "'></i> " ;
                                          gen_div += "<span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += " <i class='fa fa-angle-left pull-right'></i> ";
                                          gen_div += " </span></a> ";
                                          gen_div += "<ul class='treeview-menu'>";
                                          gen_div += li_child;
                                          gen_div += " </ul></li>";
                                      }
                                      else
                                      {
                                          gen_div += " <li class='treeview'> ";
                                          gen_div += "<a href='#'> ";
                                          gen_div += "<i class='" + img + "'></i> " ;
                                          gen_div += " <span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += "  <i class='fa fa-angle-left pull-right'></i> ";
                                          gen_div += " </span></a> ";
                                          gen_div += "<ul class='treeview-menu'>";
                                          gen_div += li_child;

                                          gen_div += " </ul></li>";
                                      }
                                  }
                        		  else
                                  {
                                      if (this.IsActive(CGlobal.C_UserInfo.mainmenu.get(i)))
                                      {
                                          gen_div += " <li class='active'> <a href='" + CGlobal.C_UserInfo.mainmenu.get(i).app_path + "'> " ;
                                          gen_div += " <i class='fa fa-th'></i><span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += " </span> ";
                                          gen_div += " </a> ";
                                          gen_div += "</li> ";
                                      }
                                      else
                                      {
                                          gen_div += " <li> <a href='" + CGlobal.C_UserInfo.mainmenu.get(i).app_path + "'> " ;
                                          gen_div += " <i class='fa fa-th'></i><span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "</span> " ;
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
                  result.name = CGlobal.C_UserInfo.namempe ;
                  result.nameright = CGlobal.C_UserInfo.namempe ;
                 // result.nameposition = CGlobal.C_UserInfo.name_en + " " + CGlobal.C_UserInfo.surname_en + " - " + CGlobal.C_UserInfo.position_desc_en;
                  result.since = "Member since " + CGlobal.C_UserInfo.since_date_en;
                  String gen_div = "";
                  String app_id = "";
                  String site_map = "";
                  String site_child = "";
                  CGlobal.C_UserInfo.sitemap = new ArrayList<MainMenuObj>();
                  //Check permiss path
                  for(int i=0;i<CGlobal.C_UserInfo.mainmenu.size();i++)
                  {
                	  if(!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_path)){
                	  if(CGlobal.C_UserInfo.mainmenu.get(i).app_path.equals(strPage))
                	  {
                		  app_id = CGlobal.C_UserInfo.mainmenu.get(i).app_parent;
                		  site_map = "<section class='content-header'><h1>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "<small>" + CGlobal.C_UserInfo.mainmenu.get(i).app_head_desc_en + "</small></h1>";
                          site_child = "<li class='active'>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "</li>";
                          CGlobal.C_UserInfo.sitemap.add(CGlobal.C_UserInfo.mainmenu.get(i));
                          CGlobal.C_UserInfo.title = "Hris | " + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en;
                          check++;
                          i=CGlobal.C_UserInfo.mainmenu.size();
                	  }
                	  }
                  }
                  if (!WebUtil.IsStringEmpty(site_map))
                  {
                      site_map += "<ol class='breadcrumb'><li><a href='home'><i class='fa fa-dashboard'></i> Home</a></li>";

                      Boolean b_site = true;
                      while (b_site)
                      {
                    	  for(int i=0;i<CGlobal.C_UserInfo.mainmenu.size();i++)
                    	  {	  
                    		  b_site = false;
                    		  if(!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_id)){
                    		  if(CGlobal.C_UserInfo.mainmenu.get(i).app_id.equals(app_id) )
                    		  {
                    			  app_id = CGlobal.C_UserInfo.mainmenu.get(i).app_parent;
                                  site_child = "<li>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "</li>" + site_child;
                                  CGlobal.C_UserInfo.sitemap.add(CGlobal.C_UserInfo.mainmenu.get(i));
                                  b_site = true;  
                    		  }
                    	  }
                    	  }
                          
                      }
                      site_map += site_child + "</ol></section>";


                      result.sitemap = site_map;
                  }
                  gen_div = gen_div+ "<ul class='sidebar-menu'><li class='header'>MAIN NAVIGATION</li>";
                  for (int i = 0; i < CGlobal.C_UserInfo.mainmenu.size(); i++)
                  {
                	  if(WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_parent))
                	  {
                		  String img = "";
                          if (!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_img))
                          {
                              img = CGlobal.C_UserInfo.mainmenu.get(i).app_img;
                          }

                          String li_child = "";
                        
                        	  if (!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_id))
                              {
                        		  li_child = this.GetChild(CGlobal.C_UserInfo.mainmenu.get(i).app_id);
                        		  if (!WebUtil.IsStringEmpty(li_child))
                                  {
                        			  if (this.IsActive(CGlobal.C_UserInfo.mainmenu.get(i)))
                                      {
                                          gen_div += " <li class='active treeview'> ";
                                          gen_div += " <a href='#'> "; 
                                          gen_div += " <i class='" + img + "'></i> " ;
                                          gen_div += "<span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += " <i class='fa fa-angle-left pull-right'></i> ";
                                          gen_div += " </span></a> ";
                                          gen_div += "<ul class='treeview-menu'>";
                                          gen_div += li_child;
                                          gen_div += " </ul></li>";
                                      }
                                      else
                                      {
                                          gen_div += " <li class='treeview'> ";
                                          gen_div += "<a href='#'> ";
                                          gen_div += "<i class='" + img + "'></i> " ;
                                          gen_div += " <span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += "  <i class='fa fa-angle-left pull-right'></i> ";
                                          gen_div += " </span></a> ";
                                          gen_div += "<ul class='treeview-menu'>";
                                          gen_div += li_child;

                                          gen_div += " </ul></li>";
                                      }
                                  }
                        		  else
                                  {
                                      if (this.IsActive(CGlobal.C_UserInfo.mainmenu.get(i)))
                                      {
                                          gen_div += " <li class='active'> <a href='" + CGlobal.C_UserInfo.mainmenu.get(i).app_path + "'> " ;
                                          gen_div += " <i class='fa fa-th'></i><span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "</span> " ;
                                          gen_div += "  <span class='pull-right-container'> ";
                                          gen_div += " </span> ";
                                          gen_div += " </a> ";
                                          gen_div += "</li> ";
                                      }
                                      else
                                      {
                                          gen_div += " <li> <a href='" + CGlobal.C_UserInfo.mainmenu.get(i).app_path + "'> " ;
                                          gen_div += " <i class='fa fa-th'></i><span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "</span> " ;
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
          }
		  return  result;
	}
	private String GetChild(String appid)
      {
          if (CGlobal.C_UserInfo.lang.equals("th"))
          {
              String li = "";
              for(int i =0; i< CGlobal.C_UserInfo.mainmenu.size();i++)
              {
            	  if(!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_parent)){
            	  if(CGlobal.C_UserInfo.mainmenu.get(i).app_parent.equals(appid) )
            	  {
                          String img = "";
                          if (!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_img))
                          {
                              img = CGlobal.C_UserInfo.mainmenu.get(i).app_img;
                          }
                          String li_child = this.GetChild(CGlobal.C_UserInfo.mainmenu.get(i).app_id);

                          if (!WebUtil.IsStringEmpty(li_child))
                          {

                              if (this.IsActive(CGlobal.C_UserInfo.mainmenu.get(i)))
                              {
                                  li += " <li class='active'> ";
                                  li += " <a href='#'> ";
                                  li += " <i class='fa fa-circle-o'></i> " ;
                                  li += " <span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "</span> " ;
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
                                  li +=" <span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "</span> " ;
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
                              if (this.IsActive(CGlobal.C_UserInfo.mainmenu.get(i)))
                              {
                                  li += " <li class='active'> <a href='" + CGlobal.C_UserInfo.mainmenu.get(i).app_path + "'> ";
                                  li += " <i class='fa fa-circle-o'></i><span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "</span> </a>  </li>";
                              }
                              else
                              {
                                  li += " <li> <a href='" + CGlobal.C_UserInfo.mainmenu.get(i).app_path + "'> " ;
                                  li += " <i class='fa fa-circle-o'></i><span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc + "</span> </a>  </li>";
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
              for(int i =0; i< CGlobal.C_UserInfo.mainmenu.size();i++)
              {
            	  if(!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_parent)){
            	  if(CGlobal.C_UserInfo.mainmenu.get(i).app_parent.equals(appid) )
            	  {
                          String img = "";
                          if (!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.mainmenu.get(i).app_img))
                          {
                              img = CGlobal.C_UserInfo.mainmenu.get(i).app_img;
                          }
                          String li_child = this.GetChild(CGlobal.C_UserInfo.mainmenu.get(i).app_id);

                          if (!WebUtil.IsStringEmpty(li_child))
                          {

                              if (this.IsActive(CGlobal.C_UserInfo.mainmenu.get(i)))
                              {
                                  li += " <li class='active'> ";
                                  li += " <a href='#'> ";
                                  li += " <i class='fa fa-circle-o'></i> " ;
                                  li += " <span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "</span> " ;
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
                                  li +=" <span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "</span> " ;
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
                              if (this.IsActive(CGlobal.C_UserInfo.mainmenu.get(i)))
                              {
                                  li += " <li class='active'> <a href='" + CGlobal.C_UserInfo.mainmenu.get(i).app_path + "'> ";
                                  li += " <i class='fa fa-circle-o'></i><span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "</span> </a>  </li>";
                              }
                              else
                              {
                                  li += " <li> <a href='" + CGlobal.C_UserInfo.mainmenu.get(i).app_path + "'> " ;
                                  li += " <i class='fa fa-circle-o'></i><span>" + CGlobal.C_UserInfo.mainmenu.get(i).app_desc_en + "</span> </a>  </li>";
                              }
                          }

                      }
            	  }

              
              }
           
              return li;
          }
      }
	
	 private Boolean IsActive(MainMenuObj main_menu)
     {
		 Boolean ref_check = false;
         for(int i=0;i<CGlobal.C_UserInfo.sitemap.size();i++)
         {
        	 if(!WebUtil.IsStringEmpty(CGlobal.C_UserInfo.sitemap.get(i).app_id)){
        	 if(CGlobal.C_UserInfo.sitemap.get(i).app_id.equals(main_menu.app_id) )
        	 {
        		 i= CGlobal.C_UserInfo.sitemap.size();
        		 ref_check = true;
        		 
        	 }
        	 }
         }
         
         return ref_check;
     }
}
