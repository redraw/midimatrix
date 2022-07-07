sync:
	rsync -av . pi@raspberry.local:~/midigrid

install-deps:
	# luma.oled system dependencies
	sudo apt install python3 python3-pip python3-pil libjpeg-dev zlib1g-dev libfreetype6-dev liblcms2-dev libopenjp2-7 libtiff5 -y

install: install-deps
	pip install -r requirements.txt
	cp midigrid.service /lib/systemd/system/midigrid.service
	systemctl enable midigrid.service
	systemctl daemon-reload
	systemctl start midigrid.service
