<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<!-- Custom Theme Style -->
<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">

<!-- page content -->
<!-- 회원수 현황 -->
<div class="row top_tiles">
	<!-- 전체 회원수 시작 -->
	<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="tile-stats">
			<div class="icon"><i class="fa fa-male"></i></div>
			<div class="count blue">${total}</div>
			<h3>전체 회원수</h3>
			<p>${today}</p>
		</div>
	</div>
	<!-- 전체 회원수 끝 -->

	<!-- 커뮤니티 회원수 시작 -->
	<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="tile-stats"><div class="icon"><i class="fa fa-comments-o"></i></div>
			<div class="count blue">${community}</div>
			<h3>커뮤니티 회원수</h3>
			<p>${today}</p>
		</div>
	</div>
	<!-- 커뮤니티 회원수 끝 -->

	<!-- 새로 가입한 회원수 시작 -->
	<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="tile-stats"><div class="icon"><i class="fa fa-child"></i></div>
			<div class="count blue">${recentJoin}</div>
			<h3>새로 가입한 회원수</h3>
			<p>${first}~ ${today}</p>
		</div>
	</div>
	<!-- 새로 가입한 회원수 끝 -->

	<!-- 우리 모임 생일 시작  -->
	<div class="animated flipInY col-lg-3 col-md-3 col-sm-6 col-xs-12">
		<div class="tile-stats">
			<div class="icon"><i class="fa fa-birthday-cake"></i></div>
			<div class="count blue">
				+${cntFoundation}<small>Day</small>
			</div>
			<h3>우리 모임 생일</h3>
			<p>${foundation}</p>
		</div>
	</div>
	<!-- 우리 모임 생일 끝 -->	
</div>
<!-- 회원수 현황 -->
	
<!-- 회원수 그래프 -->
<div class="row">
	<div class="col-md-12">
		<div class="x_panel">
			<div class="x_title">
				<h2>회원 현황</h2>
				<ul class="nav navbar-right panel_toolbox">
					<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
						<i class="fa fa-wrench"></i></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">Settings 1</a></li>
							<li><a href="#">Settings 2</a></li>
						</ul></li>
					<li><a class="close-link"><i class="fa fa-close"></i></a></li>
				</ul>
				<div class="clearfix"></div>
			</div>

			<div class="x_content">
				<!-- 월별 회원수 그래프 시작 -->
				<div class="x_panel">
					<div id="monthly" style="height: 350px;"></div>
				</div>
				<!-- 월별 회원수 그래프 끝 -->
				
				<!-- 년도별 회원수 그래프 시작 -->
				<div class="x_panel">
					<div id="annual" style="height: 350px;"></div>
				</div>
				<!-- 년도별 회원수 그래프 끝 -->
				
				<!-- 남성/여성 비율 그래프 시작 -->
				<div class="col-md-3 col-sm-3 col-xs-12">
					<div class="x_panel">
						<div class="x_title">
							<h2>남성/여성 비율</h2>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
							<div id="gender_donut" style="height: 350px;"></div>
						</div>
					</div>
				</div>
				<!-- 남성/여성 비율 그래프 끝 -->
				
				<!-- 커뮤니티 가입 비율 그래프 시작 -->
				<div class="col-md-3 col-sm-3 col-xs-12">
					<div class="x_panel">
						<div class="x_title">
							<h2>커뮤니티 가입 비율</h2>
							<div class="clearfix"></div>
						</div>
						<div class="x_content">
							<div id="communityJoin_donut" style="height: 350px;"></div>
						</div>
					</div>
				</div>
				<!-- 커뮤니티 가입 비율 그래프 끝 -->
				
				<!-- 최근 가입한 회원 시작 -->
				<div class="col-md-3 col-sm-3 col-xs-12">
					<div class="x_panel">
						<div>
							<div class="x_title">
								<h2>최근 가입한 회원</h2>
								<div class="clearfix"></div>
							</div>
							<ul class="list-unstyled top_profiles scroll-view">
								<c:forEach var="dto" items="${list}">
									<li class="media event"><a class="pull-left border-aero profile_thumb">
									<i class="fa fa-user green"></i></a>
										<div class="media-body">
											<a class="title" href="#">${dto.name}</a>
											<p><strong>
												<c:if test="${dto.userId != null}">커뮤니티 아이디 : ${dto.userId}</c:if>
												<c:if test="${dto.userId == null}">
												<p style="color: orange;">커뮤니티 미가입</p></c:if></strong></p>
											<p><small>가입일: ${dto.joinDate}</small></p>
										</div></li>
								</c:forEach>
							</ul>
						</div>
					</div>									
				</div>
				<!-- 최근 가입한 회원 끝 -->
				
				<!-- 이번 달 생일인 회원 시작 -->
				<div class="col-md-3 col-sm-3 col-xs-12">
					<div class="x_panel">
						<div>
							<div class="x_title">
								<h2>이번 달에 생일인 회원</h2>
								<div class="clearfix"></div>
							</div>
							<ul class="list-unstyled top_profiles scroll-view">
								<c:forEach var="dto" items="${birthList}">
									<li class="media event"><a class="pull-left border-aero profile_thumb">
									<i class="fa fa-user blue"></i></a>
										<div class="media-body">
											<a class="title" href="#">${dto.name}</a>
											<p><strong>
												<c:if test="${dto.userId != null}">커뮤니티 아이디 : ${dto.userId}</c:if>
												<c:if test="${dto.userId == null}">
												<p style="color: orange;">커뮤니티 미가입</p></c:if></strong></p>
											<p><small>생일: ${dto.birth}</small></p>
										</div></li>
								</c:forEach>
							</ul>
						</div>
					</div>									
				</div>
				<!-- 이번 달 생일인 회원 끝 -->								
			</div>
		</div>
	</div>
</div>
<!-- 회원수 그래프 끝 -->

<!-- 회원수 그래프 시작 -->
<div class="row">
	<div class="col-md-12">
		<div class="x_panel">
			<div class="panel panel-body">
				<div class="x_title">
					<h4>출석률 현황</h4>
				</div>
                         
				<div class="row">
					<div class="col-xs-4">
						<span class="chart" data-percent="70">
							<span class="percent"></span>
						</span>
					</div>
					<div class="col-xs-4">
						<span class="chart" data-percent="60">
							<span class="percent"></span>
						</span>
					</div>
					<div class="col-xs-4">
						<span class="chart" data-percent="10">
							<span class="percent"></span>
						</span>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>									
		</div>
	</div>
</div>
<!-- 회원수 그래프 끝 -->

<!-- /page content -->

<!-- FastClick -->
<script src="<%=cp%>/res/js/admin/fastclick.js"></script>
<!-- ECharts -->
<script src="<%=cp%>/res/js/admin/echarts.min.js"></script>
<!-- NProgress -->
<script src="<%=cp%>/res/js/admin/nprogress.js"></script>
<!-- easy-pie-chart -->
<script src="<%=cp%>/res/js/admin/jquery.easypiechart.min.js"></script>


<script>
    var theme = {
            color: [
                '#9B59B6', '#3498DB', '#BDC3C7', '#34495E',
                '#26B99A', '#8abb6f', '#759c6a', '#bfd3b7'
            ],

            title: {
                itemGap: 8,
                textStyle: {
                    fontWeight: 'normal',
                    color: '#34495E'
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
		
    	// 월별 인원수 현황 그래프	
        var echartBar = echarts.init(document.getElementById('monthly'), theme);

        echartBar.setOption({
          title: {
            text: '월별 회원수 집계 현황',
            subtext: '2016년' // 년도를 출력해야함.
          },
          tooltip: {
            trigger: 'axis'
          },
          legend: {
            data: ['회원수']
          },
          toolbox: {
            show: false
          },
          calculable: false,
          xAxis: [{
            type: 'category',
            data: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
          }],
          yAxis: [{
            type: 'value'
          }],
          series: [{
            name: '회원수',            
            type: 'bar',
            data: [2, 5, 7, 23, 25, 76, null, null, null, null, null, null], // 12개의 값을 넣되, 없으면 null이어야함. 
            markPoint: { // 자동 계산됨.
              data: [{
                type: 'max',
                name: '최대 회원수'
              }, {
                type: 'min',
                name: '최소 회원수'
              }]
            },      
          }]
        });
        
        // 년도별 인원수 현황 그래프
        var echartBar = echarts.init(document.getElementById('annual'), theme);

        echartBar.setOption({
          title: {
            text: '년도별 회원수 현황',
            subtext: '작년 ~ 올해'
          },
          tooltip: {
            trigger: 'axis'
          },
          legend: {
            data: ['작년', '올해']
          },
          toolbox: {
            show: false
          },
          calculable: false,
          xAxis: [{
            type: 'category',
            data: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
          }],
          yAxis: [{
            type: 'value'
          }],
          series: [{
            name: '작년',
            type: 'bar',
            data: [2.0, 4.9, 7.0, 23.2, 25.6, 76.7, 135.6, 162.2, 32.6, 20.0, 6.4, 3.3], // 작년 월별 회원수
            markPoint: { // 자동 계산됨
              data: [{
                type: 'max',
                name: '최대 회원수'
              }, {
                type: 'min',
                name: '최소 회원수'
              }]
            },
            markLine: { // 자동 계산됨
              data: [{
                type: 'average',
                name: '평균'
              }]
            }
          }, {
            name: '올해',
            type: 'bar',
            data: [2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2/* , 48.7, 18.8, 6.0, 2.3 */], // 올해 월별 회원수
            markPoint: {
              data: [{
            	  type: 'max',
                  name: '최대 회원수'
              }, {
            	  type: 'min',
                  name: '최소 회원수'
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
        
        // 남성/여성 비율 도넛 차트
        var echartDonut = echarts.init(document.getElementById('gender_donut'), theme);
        
        echartDonut.setOption({
          tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
          },
          calculable: true,
          legend: {
            x: 'center',
            y: 'bottom',
            data: ['남성', '여성']
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
                    funnelAlign: 'center',
                    max: 1548
                  }
                }
              }
            }
          },
          series: [{
            name: '남성/여성 비율',            
            type: 'pie',
            radius: ['35%', '55%'],
            itemStyle: {
              normal: {
                label: {
                  show: true
                },
                labelLine: {
                  show: true
                }
              },
              emphasis: {
                label: {
                  show: true,
                  position: 'center',
                  textStyle: {
                    fontSize: '14',
                    fontWeight: 'normal'
                  }
                }
              }
            },
            data: [{
              value: 335, // 남성의 수
              name: '남성'
            }, {
              value: 310, // 여성의 수
              name: '여성'
            }]
          }]
        });
        
     	// 커뮤니티 가입 비율 도넛 차트
        var echartDonut = echarts.init(document.getElementById('communityJoin_donut'), theme);
        
        echartDonut.setOption({
          tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
          },
          calculable: true,
          legend: {
            x: 'center',
            y: 'bottom',
            data: ['가입', '미가입']
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
                    funnelAlign: 'center',
                    max: 1548
                  }
                }
              }
            }
          },
          series: [{
            name: '커뮤니티 가입 비율',    
            type: 'pie',
            radius: ['35%', '55%'],
            itemStyle: {
              normal: {
                label: {
                  show: true
                },
                labelLine: {
                  show: true
                }
              },
              emphasis: {
                label: {
                  show: true,
                  position: 'center',
                  textStyle: {
                    fontSize: '14',
                    fontWeight: 'normal'
                  }
                }
              }
            },
            data: [{
              value: 335, // 가입자 수
              name: '가입'
            }, {
              value: 310, // 미가입자 수
              name: '미가입'
            }]
          }]
        });
        
        // 출석률 현황
        $(document).ready(function() {
            $('.chart').easyPieChart({
              easing: 'easeOutBounce',
              lineWidth: '6',
              barColor: '#75BCDD',
              onStep: function(from, to, percent) {
                $(this.el).find('.percent').text(Math.round(percent));
              }
			});
            
            var chart = window.chart = $('.chart').data('easyPieChart');
            $('.js_update').on('click', function() {
              chart.update(Math.random() * 200 - 100);
            });

            //hover and retain popover when on popover content
            var originalLeave = $.fn.popover.Constructor.prototype.leave;
            $.fn.popover.Constructor.prototype.leave = function(obj) {
              var self = obj instanceof this.constructor ?
                obj : $(obj.currentTarget)[this.type](this.getDelegateOptions()).data('bs.' + this.type);
              var container, timeout;

              originalLeave.call(this, obj);

              if (obj.currentTarget) {
                container = $(obj.currentTarget).siblings('.popover');
                timeout = self.timeout;
                container.one('mouseenter', function() {
                  //We entered the actual popover – call off the dogs
                  clearTimeout(timeout);
                  //Let's monitor popover content instead
                  container.one('mouseleave', function() {
                    $.fn.popover.Constructor.prototype.leave.call(self, self);
                  });
                });
              }
            };

            $('body').popover({
              selector: '[data-popover]',
              trigger: 'click hover',
              delay: {
                show: 50,
                hide: 400
              }
            });
        });
            
    </script>