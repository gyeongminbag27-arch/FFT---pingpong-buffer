# FFT Ping-Pong Buffer — UVM Verification

FFT 처리에 사용하는 Ping-Pong Buffer의 동작을 검증하는
SystemVerilog/UVM 프로젝트입니다.

## 프로젝트 개요

Ping-Pong Buffer는 두 버퍼를 번갈아 사용하여 데이터 입력과 출력을
효율적으로 처리하는 구조입니다.

본 프로젝트에서는 ADC 측 데이터 입력과 FFT Core 측 데이터 전달 과정에서
데이터 순서, 버퍼 전환, 흐름 제어가 올바르게 동작하는지 검증합니다.

## 개발 환경

- Language: SystemVerilog
- Verification: UVM
- Simulator: Synopsys VCS
- Waveform Viewer: Synopsys Verdi

## 디렉터리 구조

```text
tb/
├── UVM_test/
│   ├── fft_buffer_env/
│   │   ├── adc_agent/
│   │   ├── core_agent/
│   │   ├── fft_buffer_env.svh
│   │   ├── fft_buffer_scoreboard.svh
│   │   └── fft_buffer_coverage.svh
│   └── 테스트 클래스
├── fft_buffer_if.sv
├── fft_buffer_pkg.sv
└── tb_top.sv

sim/
└── 시뮬레이션 관련 파일
```

## 검증 구성

- **ADC Agent**: 입력 데이터 생성 및 모니터링
- **Core Agent**: 출력 측 제어 및 모니터링
- **Scoreboard**: 기대 데이터와 실제 출력 비교
- **Coverage**: 주요 검증 시나리오의 수행 여부 확인

## 주요 검증 항목

- 입력 데이터와 출력 데이터의 일치 여부
- 데이터 순서 및 프레임 경계
- Ping-Pong Buffer 전환
- 출력 측 Backpressure
- 버퍼 Overflow 및 복구
- Reset 동작
- Random 시나리오

## 시뮬레이션 실행

프로젝트의 실행 스크립트와 VCS/UVM 환경 설정이 필요합니다.

<!-- 실제 사용하는 실행 명령을 여기에 추가하세요. -->

## 검증 결과

<!-- 테스트별 PASS/FAIL, 오류 수, Coverage 결과를 추가하세요. -->
