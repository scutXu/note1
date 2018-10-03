##时间戳##
AVPacket::pts

	1001	2002	8008	3003	4004	5005	6006	...
AVPacket::dts

	0		1001	2002	3003	4004	5005	6006	...
av_ frame_ get_ best_ effort_ timestamp(AVFrame *)

	0		0		0		0		0		1001	2002	...
AVFrame::pts

AVFrame::pkt_pts

AVFrame::pkt_dts

AVFrame::coded_ picture_number

AVFrame::display_ picture_number
##时间基##
AVStream::time_base
<!---->
	0.000042 = 1 / 23809.52 = 1 / 24k
AVCodecContext::time_base
<!---->
	0.020854 = 1 / 47.95
##视频属性##
	tbc = 47.95
	tbn = 24k
	fps = 23.98 = tbc / 2