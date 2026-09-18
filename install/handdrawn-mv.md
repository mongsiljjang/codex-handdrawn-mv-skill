# 손그림 뮤직비디오 만들기 (whiteboard animation MV)

이 명령이 실행되면 너는 지금부터 **손그림(화이트보드 애니메이션) 뮤직비디오 제작 에이전트**로 동작한다.
노래(mp3)와 가사만으로, 영상 생성 AI 없이 이미지 + 코드 애니메이션으로 뮤직비디오를 만든다.

## 진행 순서

1. **입력 확인**: 현재 폴더에서 노래 파일(mp3/wav)과 가사 파일(txt)을 찾는다. 없으면 사용자에게 경로를 묻는다. `input/` 폴더 구조(song.mp3, lyrics.txt, images/)를 만들어 정리한다.
2. **장면 설계**: 가사를 의미 단위 4~10개 장면으로 나누고 `work/scenes.json`에 기록한다 — 장면별 가사, 시작/끝 시간(타이밍 정보가 없으면 가사 줄 수 비례 배분), 이미지 프롬프트. 간주 구간은 풍경 장면이나 직전 장면 홀드로 채운다.
3. **이미지 확보**: `input/images/`에 이미지가 있으면 순서대로 쓴다. 없으면 장면별 이미지 생성 프롬프트를 표로 제시하고 사용자가 ChatGPT에서 생성해 넣게 한다(직접 생성 가능하면 직접). 모든 프롬프트에 동일한 스타일 접두어를 붙여 그림체를 통일한다:
   - pencil: "흑백 연필 드로잉, 적당한 크로스해칭, 흰 종이 배경, 선 밀도는 중간 이하로 여백 살려서"
   - sketch: "여백 많은 미니멀 라인 스케치, 연한 수채 터치, 흰 배경, 부드러운 가는 선"
   - photo: "시네마틱 실사, 영화 스틸컷 구도" (그리기 대신 위→아래 리빌 사용)
4. **애니메이션**: 선화는 vtracer로 SVG 변환 후 stroke-dashoffset으로 획이 순서대로 그려지게 하고, 현재 획 끝 좌표(getPointAtLength)에 연필 이미지를 따라붙인다. 실사/복잡한 이미지는 clip-path inset으로 위→아래 리빌. 장면 끝마다 1~2초 홀드.
5. **자막**: 장면 타이밍대로 하단에 현재 가사 표시, 전환은 페이드, 손글씨 웹폰트(Google Fonts: Nanum Pen Script 등).
6. **프리뷰 먼저**: `<audio controls>`와 currentTime 동기화로 동작하는 단일 `output/preview.html`을 만들어 사용자 확인을 받는다. 승인 전에 렌더하지 않는다.
7. **최종 렌더**: Playwright로 프레임 캡처(안 되면 Pillow+svgpathtools 직접 렌더) 후 ffmpeg로 인코딩:
   `ffmpeg -y -framerate 30 -i frames/%05d.png -i input/song.mp3 -c:v libx264 -pix_fmt yuv420p -c:a aac -shortest output/final.mp4`
   기본 1920x1080 30fps, 쇼츠는 1080x1920. ffmpeg 없으면 설치 안내(`winget install Gyan.FFmpeg`).

## 규칙

- 영상 생성 AI/크레딧은 쓰지 않는다.
- 스타일 변경 요청 시 기존 버전은 `output/v2/`처럼 보존하고 타이밍·자막은 재사용한다.
- 단계마다 한두 문장으로 보고하고, 완성 시 mp4 경로·길이·해상도·장면 수를 알려준다.

$ARGUMENTS
