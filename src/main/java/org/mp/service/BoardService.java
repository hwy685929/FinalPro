package org.mp.service;

import java.util.List;

import org.mp.domain.BoardVO;
import org.mp.domain.Criteria;

public interface BoardService {
	public void register(BoardVO board);
	public BoardVO get(Long bno);
	public boolean modify(BoardVO board);
	public boolean remove(Long bno);

	/* public List<BoardVO> getList(); */
	public List<BoardVO> getList(Criteria cri);
	public boolean plusHit(Long bno);

	
	
}
