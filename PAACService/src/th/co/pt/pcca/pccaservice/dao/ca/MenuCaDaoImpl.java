package th.co.pt.pcca.pccaservice.dao.ca;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import th.co.pt.pcca.pccaservice.entities.account.MainMenuObj;
import th.co.pt.pcca.pccaservice.entities.account.MemberAccountObj;
import th.co.pt.pcca.pccaservice.entities.member.MemberObj;
import th.co.pt.pcca.pccaservice.helper.*;

@Repository
public class MenuCaDaoImpl implements MenuCaDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private  final Logger logger = LoggerFactory.getLogger(this.getClass());
	public MemberObj GetUserPermiss(String codempid, String password) {
		MemberObj result = new MemberObj();
		try {
			StringBuilder sql = new StringBuilder();
			sql.append(" select hrpv.CODEMPID, ");
			sql.append(" hrpv.NAMEMPT,");
			sql.append(" hrpv.CODPOS,");
			sql.append(" hrpv.NAMPOSE ");
			sql.append(" from HRIS.HRIS_PROFILE_V hrpv ");
			sql.append(" where hrpv.codempid ='" + codempid + "' ");
		
			
			
			result = jdbcTemplate.queryForObject(sql.toString(),
					BeanPropertyRowMapper.newInstance(MemberObj.class));
			
			
			if (!result.codempid.equalsIgnoreCase(null)) {
				StringBuilder sql_app = new StringBuilder();
				sql_app.append(" select b.menu_id as  app_id, ");
				sql_app.append("   b.textm as app_desc,");
				//sql_app.append("   b.textm_en as app_desc_en,");
				//sql_app.append("  '' as app_head_desc,");
				//sql_app.append("  '' as app_head_desc_en,");
				sql_app.append("   b.linkm as app_path,");
				sql_app.append("   b.app_img,");
				sql_app.append("  b.app_order,");
				sql_app.append("   b.parentm as app_parent,");
				sql_app.append("   c.savep,");
				sql_app.append("   c.editp,");
				sql_app.append("   c.deletep,");
				sql_app.append("   c.addp,");
				sql_app.append("   c.approve_flg,");
				sql_app.append("   c.head_flg");
				sql_app.append("  from HRIS_MP_MENU a");
				sql_app.append("  inner join HRIS_MENU b  on a.MENU_ID =b.MENU_ID and b.STATUS =1");
				sql_app.append("  inner join HRIS_PERMISS_ITEM c on a.PMI_ID =c.PMI_ID");
				sql_app.append("   where a.GU_ID ='"+result.gu_id+"'  order by b.app_order ");

				List<MainMenuObj> main_menu = new ArrayList<MainMenuObj>();
				main_menu = jdbcTemplate.query(sql_app.toString(),
						new BeanPropertyRowMapper(MainMenuObj.class));
				
				MainMenuObj logout_menu = new MainMenuObj();
				if (main_menu.size() > 0) {
					String parent = "";
					for (int i = 0; i < main_menu.size(); i++) {
						if (result.mainmenu == null) {
							result.mainmenu = new ArrayList<MainMenuObj>();
						}
						// add menu into list
						if(main_menu.get(i).app_id.equals("0013")) {
							logout_menu = main_menu.get(i);
						} else result.mainmenu.add(main_menu.get(i));
						
						if (!WebUtil.IsStringEmpty(main_menu.get(i).app_parent)) {
							if (WebUtil.IsStringEmpty(parent)) {
								parent += "'" + main_menu.get(i).app_parent
										+ "'";
							} else {
								parent += ",'" + main_menu.get(i).app_parent
										+ "'";
							}
						}
					}
					List<MainMenuObj> parent_menu = new ArrayList<MainMenuObj>();

					if (!WebUtil.IsStringEmpty(parent)) {
						// parent_menu = this.GetParent3(parent, parent_menu);
						String last_app_id = "";
						parent = this.GetParent3(parent, parent);
						last_app_id = parent;
						if (!WebUtil.IsStringEmpty(last_app_id)) {
							StringBuilder sql_lass_app = new StringBuilder();
							sql_lass_app.append(" select  menu_id as  app_id, ");
							sql_lass_app.append("         textm as app_desc, ");
							//sql_lass_app.append("         textm_en as app_desc_en, ");
							//sql_lass_app.append("        '' as app_head_desc, ");
							//sql_lass_app.append("       '' as app_head_desc_en, ");
							sql_lass_app.append("       linkm as app_path, ");
							sql_lass_app.append("      app_img, ");
							sql_lass_app.append("    app_order, ");
							sql_lass_app.append("    parentm as app_parent ");
							sql_lass_app.append("     from  HRIS_MENU ");
							sql_lass_app
									.append("   where status =1  and menu_id in ("
											+ last_app_id + ")  ");
							sql_lass_app.append(" group by menu_id, ");
							sql_lass_app.append("  textm, ");
							//sql_lass_app.append("  textm_en, ");
							sql_lass_app.append(" linkm, ");
							sql_lass_app.append("  app_img, ");
							sql_lass_app.append(" app_order, ");
							sql_lass_app.append("   parentm ");
							sql_lass_app.append(" order by app_order ");
							List<MainMenuObj> last_menu = new ArrayList<MainMenuObj>();
							last_menu = jdbcTemplate
									.query(sql_lass_app.toString(),
											new BeanPropertyRowMapper(
													MainMenuObj.class));
							if (last_menu != null) {
								if (last_menu.size() > 0) {
									for (int i = 0; i < last_menu.size(); i++) {

										result.mainmenu.add(last_menu.get(i));
									}
								}
							}
						}
					}
				}
				result.mainmenu.add(logout_menu);
			} 
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}
	
	public MemberObj GetUserPms(String codempid, String password) {
		MemberObj result = new MemberObj();
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("select hgu.gu_id, ");
			sql.append("pro.codempid, ");
			sql.append("'th' as lang,");
			sql.append("pro.namempt ");
			sql.append("from hris_profile_v pro ");
			sql.append("join hris_center_user hcu on pro.codempid = hcu.emp_id ");
			sql.append("join hris_center hc on hcu.center_id = hc.center_id ");
			sql.append("join hris_center_company hcc on hc.center_id = hcc.center_id ");
			sql.append("join hris_group_user hgu on hcu.gu_id = hgu.gu_id ");
			sql.append("group by hgu.gu_id,pro.codempid,pro.namempt ");
			result = jdbcTemplate.queryForObject(sql.toString(),
					BeanPropertyRowMapper.newInstance(MemberObj.class));
			if (!result.codempid.equalsIgnoreCase(null)) {
				StringBuilder sql_app = new StringBuilder();
				sql_app.append("select hmm.menu_id as app_id, ");
				sql_app.append("hm.textm as app_desc, ");
				sql_app.append("hm.linkm as app_path, ");
				sql_app.append("hm.app_img, ");
				sql_app.append("hm.app_order, ");
				sql_app.append("hm.parentm as app_parent ");
				sql_app.append("from hris_mp_menu hmm ");
				sql_app.append("join hris_menu hm on hmm.menu_id = hm.menu_id ");
				sql_app.append("where hmm.gu_id = '"+ result.gu_id +"' and hm.status = 1 ");
				List<MainMenuObj> main_menu = new ArrayList<MainMenuObj>();
				main_menu = jdbcTemplate.query(sql_app.toString(),new BeanPropertyRowMapper(MainMenuObj.class));
				if (main_menu.size() > 0) {
					String parent = "";
					for (int i = 0; i < main_menu.size(); i++) {
						if (result.mainmenu == null) {
							result.mainmenu = new ArrayList<MainMenuObj>();
						}
						result.mainmenu.add(main_menu.get(i));
						if (!WebUtil.IsStringEmpty(main_menu.get(i).app_parent)) {
							if (WebUtil.IsStringEmpty(parent)) {
								parent += "'" + main_menu.get(i).app_parent
										+ "'";
							} else {
								parent += ",'" + main_menu.get(i).app_parent
										+ "'";
							}
						}
					}
					List<MainMenuObj> parent_menu = new ArrayList<MainMenuObj>();

					if (!WebUtil.IsStringEmpty(parent)) {
						String last_app_id = "";
						parent = this.GetParent3(parent, parent);
						last_app_id = parent;
						if (!WebUtil.IsStringEmpty(last_app_id)) {
							StringBuilder sql_lass_app = new StringBuilder();
							sql_lass_app.append("select  menu_id as  app_id, ");
							sql_lass_app.append("textm as app_desc, ");
							sql_lass_app.append("linkm as app_path, ");
							sql_lass_app.append("app_img, ");
							sql_lass_app.append("app_order, ");
							sql_lass_app.append("parentm as app_parent ");
							sql_lass_app.append("from HRIS_MENU ");
							sql_lass_app.append("where status =1  and menu_id in ("+ last_app_id + ")  ");
							sql_lass_app.append("group by menu_id, ");
							sql_lass_app.append("textm, ");
							sql_lass_app.append("linkm, ");
							sql_lass_app.append("app_img, ");
							sql_lass_app.append("app_order, ");
							sql_lass_app.append("parentm ");
							sql_lass_app.append("order by app_id ");
							List<MainMenuObj> last_menu = new ArrayList<MainMenuObj>();
							last_menu = jdbcTemplate.query(sql_lass_app.toString(),new BeanPropertyRowMapper(MainMenuObj.class));
							if (last_menu != null) {
								if (last_menu.size() > 0) {
									for (int i = 0; i < last_menu.size(); i++) {
										result.mainmenu.add(last_menu.get(i));
									}
								}
							}
						}
					}
				}
			}
		} catch (Exception ex) {
			logger.error(ex.getMessage(),ex);
			//ex.printStackTrace();
		}
		return result;
	}

	private List<MainMenuObj> GetParent2(String parent,
			List<MainMenuObj> list_menu) {

		if (list_menu == null) {
			list_menu = new ArrayList<MainMenuObj>();
		}
		StringBuilder sql = new StringBuilder();
		sql.append(" select menu_id as app_id, ");
		sql.append(" textm as app_desc,");
		//sql.append(" textm_en as app_desc_en,");
		//sql.append("  '' as app_head_desc,");
		//sql.append(" '' as app_head_desc_en,");
		sql.append("  linkm as app_path,");
		sql.append("   app_img,");
		sql.append("   app_order,");
		sql.append("  parentm as app_parent");
		sql.append("    from  HRIS_MENU");
		sql.append("     where status =1  and menu_id in (" + parent + ")");
		sql.append("    order by app_order");
		List<MainMenuObj> main_menu = new ArrayList<MainMenuObj>();
		main_menu = jdbcTemplate.query(sql.toString(),
				new BeanPropertyRowMapper(MainMenuObj.class));
		if (main_menu != null) {
			if (main_menu.size() > 0) {
				String child_parent = "";
				for (int i = 0; i < main_menu.size(); i++) {
					if (list_menu == null) {
						list_menu = new ArrayList<MainMenuObj>();
					}
					list_menu.add(main_menu.get(i));

					if (!WebUtil.IsStringEmpty(main_menu.get(i).app_parent)) {
						if (WebUtil.IsStringEmpty(child_parent)) {
							child_parent += "'" + main_menu.get(i).app_parent
									+ "'";
						} else {
							child_parent += ",'" + main_menu.get(i).app_parent
									+ "'";
						}
					}
				}
				if (!WebUtil.IsStringEmpty(child_parent)) {
					list_menu = this.GetParent2(child_parent, list_menu);
				}

			}
		}

		return list_menu;
	}

	private String GetParent3(String parent, String curr_parent) {
		Boolean islast = false;
		StringBuilder sql = new StringBuilder();
		sql.append(" select menu_id as app_id, ");
		sql.append(" textm as app_desc,");
		//sql.append(" textm_en as app_desc_en,");
		//sql.append(" '' as app_head_desc,");
		//sql.append(" '' as app_head_desc_en,");
		sql.append(" linkm as app_path,");
		sql.append(" app_img,");
		sql.append(" app_order,");
		sql.append(" parentm as app_parent");
		sql.append(" from  HRIS_MENU");
		sql.append(" where status =1  and menu_id in (" + parent + ")");
		sql.append(" order by app_order");
		List<MainMenuObj> main_menu = new ArrayList<MainMenuObj>();
		main_menu = jdbcTemplate.query(sql.toString(),
				new BeanPropertyRowMapper(MainMenuObj.class));
		if (main_menu != null) {
			if (main_menu.size() > 0) {
				String child_parent = "";

				for (int i = 0; i < main_menu.size(); i++) {

					if (!WebUtil.IsStringEmpty(main_menu.get(i).app_parent)) {
						if (WebUtil.IsStringEmpty(child_parent)) {
							child_parent += "'" + main_menu.get(i).app_parent
									+ "'";
						} else {
							child_parent += ",'" + main_menu.get(i).app_parent
									+ "'";
						}
					}
				}

				if (WebUtil.IsStringEmpty(child_parent)) {
					islast = true;

				} else {
					curr_parent += "," + child_parent;
					curr_parent = this.GetParent3(child_parent, curr_parent);

				}

			}
		}

		return curr_parent;
	}

	public MemberAccountObj getMemberAccount(String userId,String password){
		MemberAccountObj result = new MemberAccountObj();
		List<MemberAccountObj> member = new ArrayList<>();
		try {
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT mem.userid as userId, ");
			sql.append("mem.password, ");
			sql.append("mem.codempid as codeEmpId ");
			sql.append("FROM hris_user_account mem ");
			sql.append("where mem.codempid = '"+ userId +"'");
			member = jdbcTemplate.query(sql.toString(),
					new BeanPropertyRowMapper(MemberAccountObj.class));
			if (!member.isEmpty()) {
				List<MemberAccountObj> pass = new ArrayList<>();
				StringBuilder sql_pass = new StringBuilder();
				sql_pass.append("SELECT mem.userid as userId, ");
				sql_pass.append("mem.password, ");
				sql_pass.append("mem.codempid as codeEmpId ");
				sql_pass.append("FROM hris_user_account mem ");
				sql_pass.append("where mem.password = '"+ password +"'");
				pass = jdbcTemplate.query(sql_pass.toString(),
						new BeanPropertyRowMapper(MemberAccountObj.class));
				if (!pass.isEmpty()) {
					result.setStatus("SUCCESS");
					result.setUserId(pass.get(0).getUserId());
				} else {
					result.setStatus("PASS FAIL");
				}
			} else {
				result.setStatus("USER FAIL");
			}
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		return result;
	}

}
