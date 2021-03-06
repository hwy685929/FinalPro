package org.mp.domain;

import lombok.Data;

@Data
public class ReservationVO {

	private Long reserId;
	private String roomName;
	private String roomPeople;
	private int roomPrice;
	private String restPhone;
	private String dogType;
	private int dogNumber;
	private String restName;
	private String startDate;
	private String endDate;
	private String userId;
	private Long restId;
	
}
