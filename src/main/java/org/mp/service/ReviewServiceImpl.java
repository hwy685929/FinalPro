package org.mp.service;

import java.util.List;

import org.mp.domain.Criteria;
import org.mp.domain.ReviewVO;
import org.mp.mapper.ReviewMapper;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReviewServiceImpl implements ReviewService {
	
	@Setter
	private ReviewMapper mapper;

	@Override
	public int register(ReviewVO vo) {
		log.info("register"+vo);
		return mapper.insert(vo);
	}

	@Override
	public ReviewVO get(Long reno) {
		log.info("get"+reno);
		return mapper.read(reno);
	}

	@Override
	public int modify(ReviewVO vo) {
		log.info("modify"+vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(Long reno) {
		log.info("remove"+reno);
		return mapper.delete(reno);
	}

	@Override
	public List<ReviewVO> getList(Criteria cri, Long restId) {
		log.info("get review List"+restId);
		return mapper.getListWithPaging(cri, restId);
	}

}
