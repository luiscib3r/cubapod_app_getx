.PHONY: run
run:
	flutter run

.PHONY: build
build:
	flutter build apk --target-platform android-arm

.PHONY: generate
generate:
	flutter packages pub run build_runner build
	flutter pub run flutter_launcher_icons:main