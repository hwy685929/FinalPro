package org.mp.service;

import java.util.List;

import org.mp.domain.BoardAttachVO;
import org.mp.domain.BoardVO;
import org.mp.domain.Criteria;
import org.mp.mapper.BoardAttachMapper;
import org.mp.mapper.BoardMapper;
import org.mp.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	private BoardAttachMapper attachMapper;
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;

	@Override
	public BoardVO get(Long bno) {
		log.info("get.....");
		return mapper.read(bno);
	}

	@Transactional 
	@Override
	public void register(BoardVO board) {
		log.info("register....." + board.getBno());

		mapper.insertSelectkey(board); 
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) { 
			return; 
		}
		board.getAttachList().forEach(attach ->{ attach.setBno(board.getBno());
		attachMapper.insert(attach); });

	}	
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify...." + board);
		attachMapper.deleteAll(board.getBno());
		
	    boolean modifyResult = mapper.update(board)==1;
	    
	      if(modifyResult && board.getAttachList()!= null && board.getAttachList().size()>0) {
	    	  board.getAttachList().forEach(attach-> {
	    		  attach.setBno(board.getBno());
	    		  attachMapper.insert(attach);
	    	  });
	      }
	      return modifyResult;
	   }
	
	@Transactional 
	@Override
	public boolean remove(Long bno) {
		log.info("remove...." + bno);
		replyMapper.deleteReply(bno);
		attachMapper.deleteAttach(bno);
		attachMapper.deleteAll(bno);
		return mapper.delete(bno)==1;

	}
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with criteria : " + cri);
		return mapper.getListWithPaging(cri);
	}
	@Override
	public boolean plusHit(Long bno) {
		return mapper.plusHit(bno);
	}
	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardVO> getReply(Long bno) {
		return mapper.getReply(bno);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno : " + bno);
		return attachMapper.findByBno(bno);
	}

	






}
