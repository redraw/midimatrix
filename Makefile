NAME = midimatrix

sync:
	rsync -av . pi@raspberrypi.local:~/$(NAME)

install-deps:
	# luma.oled system dependencies
	apt install python3 python3-pip python3-pil libjpeg-dev zlib1g-dev libfreetype6-dev liblcms2-dev libopenjp2-7 libtiff5 -y

install: install-deps
	pip install -r requirements.txt
	cp $(NAME) /usr/bin/$(NAME)
	chmod +x /usr/bin/$(NAME)
	cp $(NAME).service /lib/systemd/system/$(NAME).service
	systemctl enable $(NAME).service
	systemctl daemon-reload
	systemctl start $(NAME).service
