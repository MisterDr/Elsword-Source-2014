﻿-- lua header. UTF-8 인코딩 인식을 위해 이 줄은 지우지 마세요.

----------     Global Server 설정     ----------

-- 크래쉬 리포트 메일링 리스트 --
Server:SetMailingList( "bowrain@kog.co.kr" )

-- 종료시 db 처리 대기시간 --
Server:SetShutDownWait( 60 * 1000 )

-- 넥슨 passport 인증 레벨
--Server:SetPassportLevel( 2 )

-- 스크립트 파싱 실패 리포트
Server:SetScriptParsingErrReport( true )
Server:AddScriptParsingErrReportMail( 'bowrain@kog.co.kr' ) -- 임규수

-- Add moritoring server's IP for checking port of elsword's server ( SERV_PERMIT_PORT_CHECK )
--Server:AddPortCheckMoritoringServer( "79.110.90.240" )

----------     Global NetLayer 설정     ----------

NetLayer:SetCheckSequenceNum( false ) -- 내부통신은 SequenceNum 체크필요없음


----------     Global SimLayer 설정     ----------
SimLayer:SetUseKogOTP ( true )

-- PublisherBillingConnectType Flag --
--[[
		PBCT_NONE				= 0,	
		// kncSend 떄문에 DBLayer와 일반 Manager 는 구분되어야 함
		PBCT_NORMAL		= 1,	// 일반적인 Manager 통해 (보통은 TCP, SOAP 등)
		PBCT_DB					= 2,	// DB 통신 Manager를 통해
		PBCT_UNUSUAL		= 3,	// 섞어 쓰던가 특이 사항 있는 경우
--]]
SimLayer:SetPublisherBillingConnectType (PBCT_NORMAL)
SimLayer:SetCheckCouponByPublisher ( false )

-- Nation Flag --
SimLayer:SetNationFlag( NF_BR )

-- Auth Flag --
--[[
AF_INTERNAL    : 사내 인증
AF_NEXON_KOREA : 넥슨 국내 인증
AF_GLOBAL_SERVICE
--]]
SimLayer:SetAuthFlag( AF_INTERNAL )

-- Script File Path --
SimLayer:AddPath( "D:\\ProjectX2_SVN\\source\\BR\\Trunk\\KncWX2Server\\ServerResource" ) -- server script
SimLayer:AddPath( "D:\\ProjectX2_SVN\\resource\\BR\\Trunk\\dat\\Script" ) -- client script


----------     DB Layer 설정     ----------

-- 접속 DB 목록 --
--[[
DC_ACCOUNT         : 계정
DC_GAME            : 게임
DC_LOG             : 통계
DC_NX_WEB		   : 넥슨 WEB
--]]
-- AddDB( DB 종류, file dsn, thread 개수, DBConnectionString여부 )

DBLayer:AddDB( DC_LOG,		'LOG_INTERNAL.dsn',		3, false )
DBLayer:AddDB( DC_ACCOUNT,		'ACCOUNT_INTERNAL.dsn',	1, false )

--DBLayer:AddDB( DC_SMS,		'SMS.dsn',				1, false )

----------     로그 레벨 설정     ----------

-- 로그 레벨 --
--[[
-1 : no logs
 0 : cerr, cout
 1 : cerr, cwarn, cout
 2 : cerr, cwarn, clog, cout
--]]
log( 2 )