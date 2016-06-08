<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">

<style>
	.row{
	margin-left:15%;
	}
</style>

<!-- 잔액 -->
<div class="row tile_count">
	<div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
		<span class="count_top"><i class="fa fa-user"></i> 지난 달 지출</span>
		<div class="count red">
			-
			<fmt:formatNumber value="${preMonthDto.withdrawal}"
				groupingUsed="true" />
		</div>
		<span class="count_bottom"><i class="green"><i
				class="fa fa-sort-asc"></i>34% </i> From last Month</span>
	</div>
	<div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
		<span class="count_top"><i class="fa fa-clock-o"></i> 이번 달 지출</span>
		<div class="count red">
			-
			<fmt:formatNumber value="${thisMonthDto.withdrawal}"
				groupingUsed="true" />
		</div>
		<span class="count_bottom"> <c:choose>
				<c:when test="${preMonthDto.withdrawal >= thisMonthDto.withdrawal}">
					<i class="green"><i class="fa fa-sort-desc"></i> <fmt:formatNumber
							value="${preMonthDto.withdrawal/thisMonthDto.withdrawal}"
							pattern="#" />%</i>
				</c:when>
				<c:when test="${preMonthDto.withdrawal < thisMonthDto.withdrawal}">
					<i class="red"><i class="fa fa-sort-asc"></i> <fmt:formatNumber
							value="${thisMonthDto.withdrawal/preMonthDto.withdrawal}"
							pattern="#" />%</i>
				</c:when>
			</c:choose> From last Month
		</span>
	</div>
	<div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
		<span class="count_top"><i class="fa fa-user"></i> 현재 잔액</span>
		<div class="count">
			<fmt:formatNumber value="${balance}" groupingUsed="true" />
		</div>
		<span class="count_bottom"><i class="green">${today} </i> Now
			Balance</span>
	</div>
	<div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
		<span class="count_top"><i class="fa fa-user"></i> 이번 달 수입</span>
		<div class="count green">
			+
			<fmt:formatNumber value="${thisMonthDto.deposit}" groupingUsed="true" />
		</div>
		<span class="count_bottom"> <c:choose>
				<c:when test="${preMonthDto.deposit >= thisMonthDto.deposit}">
					<i class="red"><i class="fa fa-sort-desc"></i> <fmt:formatNumber
							value="${preMonthDto.deposit/thisMonthDto.deposit}" pattern="#" />%</i>
				</c:when>
				<c:when test="${preMonthDto.deposit < thisMonthDto.deposit}">
					<i class="green"><i class="fa fa-sort-asc"></i> <fmt:formatNumber
							value="${thisMonthDto.deposit/preMonthDto.deposit}" pattern="#" />%</i>
				</c:when>
			</c:choose> From last Month
		</span>
	</div>
	<div class="col-md-2 col-sm-4 col-xs-6 tile_stats_count">
		<span class="count_top"><i class="fa fa-user"></i> 지난 달 수입</span>
		<div class="count green">
			+
			<fmt:formatNumber value="${preMonthDto.deposit}" groupingUsed="true" />
		</div>
		<span class="count_bottom"><i class="green"><i
				class="fa fa-sort-asc"></i>34% </i> From last Month</span>
	</div>
</div>
<!-- /잔액 -->


<!-- 일일차트 -->
<div class="col-md-12 col-sm-6 col-xs-12">
	<div class="x_panel">
		<div class="x_title">
			<h2>
				<small>최근 내역 현황</small>
			</h2>
			<ul class="nav navbar-right panel_toolbox">
				<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
				</li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false"><i
						class="fa fa-wrench"></i></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">Settings 1</a></li>
						<li><a href="#">Settings 2</a></li>
					</ul></li>
				<li><a class="close-link"><i class="fa fa-close"></i></a></li>
			</ul>
			<div class="clearfix"></div>
		</div>
		<div class="x_content">

			<div id="echart_line" style="height: 350px;"></div>

		</div>
	</div>
</div>
<!-- /일일차트 -->

<!-- 월 선택 -->
<div class="row tile_count" style="margin-right:17%;">
	<div class="tile_stats_count">
		<div class="count" style="text-align: center; padding-top:45px;">
			<c:if test="${mvo!=1}">
            <a href="javascript:location.href='<%=cp%>/account/state/${url}?year=${year}&month=${month-1}';"><i class="glyphicon glyphicon-chevron-left"></i></a></c:if>
                 ${year}년  ${month}월
            <c:if test="${tvo!=1}">
            <a href="javascript:location.href='<%=cp%>/account/state/${url}?year=${year}&month=${month+1}';"><i class="glyphicon glyphicon-chevron-right"></i></a></c:if>
		</div>
	</div>
</div>
<!-- /월 선택 -->

<!-- 카테고리별 지출 현황 -->
<div class="col-md-6 col-sm-8 col-xs-12">
	<div class="x_panel">
		<div class="x_title">
			<h2><small>카테고리별 지출 현황</small></h2>
			<ul class="nav navbar-right panel_toolbox">
				<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
				</li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false"><i
						class="fa fa-wrench"></i></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">Settings 1</a></li>
						<li><a href="#">Settings 2</a></li>
					</ul></li>
				<li><a class="close-link"><i class="fa fa-close"></i></a></li>
			</ul>
			<div class="clearfix"></div>
		</div>
		<div class="x_content">

			<div id="mainb" style="height: 350px;"></div>

		</div>
	</div>
</div>
<!-- /카테고리별 지출 현황 -->

<!-- 수입(파이 차트) -->
<div class="col-md-6 col-sm-4 col-xs-12">
	<div class="x_panel">
		<div class="x_title">
			<h2><small>카테고리 별 수입 현황</small></h2>
			<ul class="nav navbar-right panel_toolbox">
				<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
				</li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false"><i
						class="fa fa-wrench"></i></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">Settings 1</a></li>
						<li><a href="#">Settings 2</a></li>
					</ul></li>
				<li><a class="close-link"><i class="fa fa-close"></i></a></li>
			</ul>
			<div class="clearfix"></div>
		</div>
		<div class="x_content">

		<div id="echart_pie" style="height: 350px;"></div>
		</div>
	</div>
</div>
<!-- /수입(파이 차트) -->

<!-- 월별 수입/지출 현황 -->
<div class="col-md-8 col-sm-8 col-xs-12" style="min-height:600px;">
	<div class="x_panel">
		<div class="x_title">
			<h2><small>월별 차트</small></h2>
			<ul class="nav navbar-right panel_toolbox">
				<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
				</li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false"><i
						class="fa fa-wrench"></i></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">Settings 1</a></li>
						<li><a href="#">Settings 2</a></li>
					</ul></li>
				<li><a class="close-link"><i class="fa fa-close"></i></a></li>
			</ul>
			<div class="clearfix"></div>
		</div>
		<div class="x_content">

			<div id="mainline" style="height: 350px;"></div>

		</div>
	</div>
</div>
<!-- /월별 수입/지출 현황 -->

<div class="col-md-4 col-sm-4 col-xs-12">
	<div class="x_panel">
		<div class="x_title">
			<h2><small>일정별 현황</small></h2>
			<ul class="nav navbar-right panel_toolbox">
				<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
				</li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-expanded="false"><i
						class="fa fa-wrench"></i></a>
					<ul class="dropdown-menu" role="menu">
						<li><a href="#">Settings 1</a></li>
						<li><a href="#">Settings 2</a></li>
					</ul></li>
				<li><a class="close-link"><i class="fa fa-close"></i></a></li>
			</ul>
			<div class="clearfix"></div>
		</div>
		<div class="x_content">

			<div id="echart_bar_horizontal" style="height: 370px;"></div>

		</div>
	</div>
</div>


<script src="<%=cp%>/res/js/admin/fastclick.js"></script>
<script src="<%=cp%>/res/js/admin/nprogress.js"></script>
<script src="<%=cp%>/res/js/admin/raphael/raphael.min.js"></script>

<!-- 막대그래프 -->
<script src="<%=cp%>/res/js/admin/morris.js/morris.min.js"></script>

<!-- 파이그래프 -->
<script src="<%=cp%>/res/js/admin/echarts/dist/echarts.min.js"></script>
<script src="<%=cp%>/res/js/admin/echarts/map/js/world.js"></script>

<script>
      var theme = {
          color: [
              '#26B99A', '#E63E3E', '#BDC3C7', '#3498DB',
              '#9B59B6', '#8abb6f', '#759c6a', '#bfd3b7'
          ],

          title: {
              itemGap: 8,
              textStyle: {
                  fontWeight: 'normal',
                  color: '#408829'
              }
          },

          dataRange: {
              color: ['#1f610a', '#97b58d']
          },

          toolbox: {
              color: ['#408829', '#408829', '#408829', '#408829']
          },

          tooltip: {
              backgroundColor: 'rgba(0,0,0,0.5)',
              axisPointer: {
                  type: 'line',
                  lineStyle: {
                      color: '#408829',
                      type: 'dashed'
                  },
                  crossStyle: {
                      color: '#408829'
                  },
                  shadowStyle: {
                      color: 'rgba(200,200,200,0.3)'
                  }
              }
          },

          dataZoom: {
              dataBackgroundColor: '#eee',
              fillerColor: 'rgba(64,136,41,0.2)',
              handleColor: '#408829'
          },
          grid: {
              borderWidth: 0
          },

          categoryAxis: {
              axisLine: {
                  lineStyle: {
                      color: '#408829'
                  }
              },
              splitLine: {
                  lineStyle: {
                      color: ['#eee']
                  }
              }
          },

          valueAxis: {
              axisLine: {
                  lineStyle: {
                      color: '#408829'
                  }
              },
              splitArea: {
                  show: true,
                  areaStyle: {
                      color: ['rgba(250,250,250,0.1)', 'rgba(200,200,200,0.1)']
                  }
              },
              splitLine: {
                  lineStyle: {
                      color: ['#eee']
                  }
              }
          },
          timeline: {
              lineStyle: {
                  color: '#408829'
              },
              controlStyle: {
                  normal: {color: '#408829'},
                  emphasis: {color: '#408829'}
              }
          },

          k: {
              itemStyle: {
                  normal: {
                      color: '#68a54a',
                      color0: '#a9cba2',
                      lineStyle: {
                          width: 1,
                          color: '#408829',
                          color0: '#86b379'
                      }
                  }
              }
          },
          map: {
              itemStyle: {
                  normal: {
                      areaStyle: {
                          color: '#ddd'
                      },
                      label: {
                          textStyle: {
                              color: '#c12e34'
                          }
                      }
                  },
                  emphasis: {
                      areaStyle: {
                          color: '#99d2dd'
                      },
                      label: {
                          textStyle: {
                              color: '#c12e34'
                          }
                      }
                  }
              }
          },
          force: {
              itemStyle: {
                  normal: {
                      linkStyle: {
                          strokeColor: '#408829'
                      }
                  }
              }
          },
          chord: {
              padding: 4,
              itemStyle: {
                  normal: {
                      lineStyle: {
                          width: 1,
                          color: 'rgba(128, 128, 128, 0.5)'
                      },
                      chordStyle: {
                          lineStyle: {
                              width: 1,
                              color: 'rgba(128, 128, 128, 0.5)'
                          }
                      }
                  },
                  emphasis: {
                      lineStyle: {
                          width: 1,
                          color: 'rgba(128, 128, 128, 0.5)'
                      },
                      chordStyle: {
                          lineStyle: {
                              width: 1,
                              color: 'rgba(128, 128, 128, 0.5)'
                          }
                      }
                  }
              }
          },
          gauge: {
              startAngle: 225,
              endAngle: -45,
              axisLine: {
                  show: true,
                  lineStyle: {
                      color: [[0.2, '#86b379'], [0.8, '#68a54a'], [1, '#408829']],
                      width: 8
                  }
              },
              axisTick: {
                  splitNumber: 10,
                  length: 12,
                  lineStyle: {
                      color: 'auto'
                  }
              },
              axisLabel: {
                  textStyle: {
                      color: 'auto'
                  }
              },
              splitLine: {
                  length: 18,
                  lineStyle: {
                      color: 'auto'
                  }
              },
              pointer: {
                  length: '90%',
                  color: 'auto'
              },
              title: {
                  textStyle: {
                      color: '#333'
                  }
              },
              detail: {
                  textStyle: {
                      color: 'auto'
                  }
              }
          },
          textStyle: {
              fontFamily: 'Arial, Verdana, sans-serif'
          }
      };
      
      // 카테고리별 현황 
      
      var echartBar = echarts.init(document.getElementById('mainb'), theme);

      echartBar.setOption({
        tooltip: {
          trigger: 'axis'
        },
        toolbox: {
            show: true,
            feature: {
              saveAsImage: {
                show: true,
                title: "Save Image"
              }
            }
          },
        legend: {
          data: ['지출액']
        },
        calculable: false,
        xAxis: [{
          type: 'category',
          data: [
			<c:forEach var="dto" items="${cateList}">
				{value: "${dto.accountName}"},
			</c:forEach>
                 ]
        }],
        yAxis: [{
          type: 'value'
        }],
        series: [{
          name: '지출액',
          type: 'bar',
          data: [
			<c:forEach var="dto" items="${cateList}">
				{value: "${dto.withdrawal}"},
			</c:forEach>
                 ],
          markPoint: {
            data: [{
              type: 'max',
              name: '최고지출'
            }, {
              type: 'min',
              name: '최소지출'
            }]
          },
          markLine: {
            data: [{
              type: 'average',
              name: '평균'
            }]
          }
        }]
      });
      
      
      // 월별 현황
      var echartLine = echarts.init(document.getElementById('mainline'), theme);

      echartLine.setOption({
        tooltip: {
          trigger: 'axis'
        },
        toolbox: {
            show: true,
            feature: {
              saveAsImage: {
                show: true,
                title: "Save Image"
              }
            }
          },
        legend: {
          data: ['출금액', '입금액']
        },
        calculable: false,
        xAxis: [{
          type: 'category',
          data: [
			<c:forEach var="dto" items="${monthList}">
				{value: "${dto.tranDate}"},
			</c:forEach>
                 ]
        }],
        yAxis: [{
          type: 'value'
        }],
        series: [{
            name: '입금액',
            type: 'line',
            data: [
  			<c:forEach var="dto" items="${monthList}">
  				{value: "${dto.deposit}"},
  			</c:forEach>
                   ],
            markPoint: {
              data: [{
                type: 'max',
                name: '최고수입'
              }, {
                type: 'min',
                name: '최소수입'
              }]
            },
            markLine: {
              data: [{
                type: 'average',
                name: '평균'
              }]
            }
          },{
          name: '출금액',
          type: 'line',
          data: [
			<c:forEach var="dto" items="${monthList}">
				{value: "${dto.withdrawal}"},
			</c:forEach>
                 ],
          markPoint: {
            data: [{
              type: 'max',
              name: '최고지출'
            }, {
              type: 'min',
              name: '최소지출'
            }]
          },
          markLine: {
            data: [{
              type: 'average',
              name: '평균'
            }]
          }
        }]
      });

      var echartPie = echarts.init(document.getElementById('echart_pie'), theme);

      echartPie.setOption({
        tooltip: {
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            x: 'center',
            y: 'bottom',
            data: [
			<c:forEach var="dto" items="${depositList}">
				{name: "${dto.accountName}"},
			</c:forEach>
			]
        },
        toolbox: {
          show: true,
          feature: {
            magicType: {
              show: true,
              type: ['pie', 'funnel'],
              option: {
                funnel: {
                  x: '25%',
                  width: '50%',
                  funnelAlign: 'left',
                  max: 1548
                }
              }
            },
            saveAsImage: {
              show: true,
              title: "Save Image"
            }
          }
        },
        calculable: true,
        series: [{
          name: '카테고리 별 수입',
          type: 'pie',
          radius: '55%',
          center: ['50%', '48%'],
          data: [
			<c:forEach var="dto" items="${depositList}">
				{value: "${dto.deposit}", name: "${dto.accountName}"},
			</c:forEach>
          ]
        }]
      });

      var dataStyle = {
        normal: {
          label: {
            show: false
          },
          labelLine: {
            show: false
          }
        }
      };

      var placeHolderStyle = {
        normal: {
          color: 'rgba(0,0,0,0)',
          label: {
            show: false
          },
          labelLine: {
            show: false
          }
        },
        emphasis: {
          color: 'rgba(0,0,0,0)'
        }
      };
      

      var echartBar = echarts.init(document.getElementById('echart_bar_horizontal'), theme);

      echartBar.setOption({
        tooltip: {
          trigger: 'axis'
        },
        legend: {
          x: 180,
          data: ['출금액', '입금액']
        },
        toolbox: {
          show: true,
          feature: {
            saveAsImage: {
              show: true,
              title: "Save Image"
            }
          }
        },
        calculable: true,
        xAxis: [{
          type: 'value',
          boundaryGap: false
        }],
        yAxis: [{
          type: 'category',
          data: [
			<c:forEach var="dto" items="${eventList}">
			{value: "${dto.eventNo}"},
			</c:forEach>
			]
        }],
        series: [{
          name: '출금액',
          type: 'bar',
          data: [
			<c:forEach var="dto" items="${eventList}">
			{value: "${dto.withdrawal}"},
			</c:forEach>
			]
        }, {
          name: '입금액',
          type: 'bar',
          data: [
            <c:forEach var="dto" items="${eventList}">
			{value: "${dto.deposit}"},
			</c:forEach>]
        }],
        
      });

      var echartLine = echarts.init(document.getElementById('echart_line'), theme);

      echartLine.setOption({
        tooltip: {
          trigger: 'item'
        },
        toolbox: {
            show: true,
            feature: {
              saveAsImage: {
                show: true,
                title: "Save Image"
              }
            }
          },
        legend: {
          x: '45%',
          y: 15,
          data: ['입금액', '출금액']
        },
        calculable: true,
        xAxis: [{
          type: 'category',
          boundaryGap: false,
          data: [
			<c:forEach var="dto" items="${dayList}">
				{value: "${dto.tranDate}"},
			</c:forEach>
                 ]
        }],
        yAxis: [{
          type: 'value'
        }],
        series: [{
          name: '입금액',
          type: 'line',
          smooth: true,
          itemStyle: {
            normal: {
              areaStyle: {
                type: 'default'
              }
            }
          },
          data: [
			<c:forEach var="dto" items="${dayList}">
				{value: "${dto.deposit}"},
			</c:forEach>
                 ]
        }, {
          name: '출금액',
          type: 'line',
          smooth: true,
          itemStyle: {
            normal: {
              areaStyle: {
                type: 'default'
              }
            }
          },
          data: [
            <c:forEach var="dto" items="${dayList}">
				{value: "${dto.withdrawal}"},
			</c:forEach>]
        }]
      });

    </script>