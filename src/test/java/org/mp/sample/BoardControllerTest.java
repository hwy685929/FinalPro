package org.mp.sample;

import javax.sql.DataSource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mp.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
		,"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@Log4j
public class BoardControllerTest {
	@Setter(onMethod_ = {@Autowired})
	private WebApplicationContext ctx;
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper mapper;
	private PasswordEncoder pwencoder;
	private DataSource ds;
	private MockMvc mockMvc;	//MockMvc : 가짜 mvc
	
	   public final PasswordEncoder getPwencoder() {
		   return pwencoder;
	   }
	   @Autowired
	   public final void setPwencoder(PasswordEncoder pwencoder) {
	   this.pwencoder = pwencoder;
	   }
	   public final DataSource getDs() {
		   return ds;
	   }
	   @Autowired
	   public final void setDs(DataSource ds) {
		   this.ds = ds;
	   }
	
	@Before		//모든 테스트 전에 매번 실행
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build(); 
	}
	
	@Test
	public void testList() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/list")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testList1() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/main")).andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testRegister() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register").param("title", "애견호텔 추천 좀 해주세요")
			.param("content", "추천부탁드려요").param("userId", "11233")).andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	
	@Test
	public void testGet() throws Exception {
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get").param("bno", "202")).andReturn()
				.getModelAndView().getModelMap());
	}
	
	@Test
	public void testModify() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/modify").param("bno", "541")
				.param("title", "541번541번").param("content", "541번 내용").param("userId", "541번 유저"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	
	@Test
	public void testRemove() throws Exception {
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove").param("bno", "541"))
				.andReturn().getModelAndView().getViewName();
		log.info(resultPage);
	}
	
	@Test
	public void testListPaging() throws Exception{
		log.info(mockMvc.perform(
				MockMvcRequestBuilders.get("/board/list")
				.param("pageNum", "2")
				.param("amount", "50"))
				.andReturn().getModelAndView().getModelMap());
	}
	

	@Test
	public void testListPaging1() throws Exception{
		log.info(mockMvc.perform(
				MockMvcRequestBuilders.get("/main")
				.param("pageNum", "2")
				.param("amount", "5"))
				.andReturn().getModelAndView().getModelMap());
	}
	
}
