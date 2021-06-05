package org.mp.service;

import java.util.List;

import javax.inject.Inject;

import org.mp.domain.BoardVO;
import org.mp.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	@Inject
	private BoardDAO dao;
	@Override
	public BoardVO get(Long bno) {
		log.info("get.....");
		try {
			dao.boardHit(bno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapper.read(bno);
	}
	@Override
	public void register(BoardVO board) {
		log.info("register....." + board.getBno());
		mapper.insertSelectkey(board);
	}
	@Override
	public boolean modify(BoardVO board) {
		log.info("modyfi...." + board);
		return mapper.update(board)==1;
	}
	@Override
	public boolean remove(Long bno) {
		log.info("remove...." + bno);
		return mapper.delete(bno)==1;
	}
	@Override
	public List<BoardVO> getList() {
		log.info("getList....");
		return mapper.getList();
	}
	

	
}
