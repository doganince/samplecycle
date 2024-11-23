#!/bin/sh
color_success=$'\033[0;32m'
color_info=$'\033[0;33m'

if which minikube > /dev/null; 
then
	minikube delete --all --purge
	minikube stop
	brew uninstall minikube
	echo "$color_success!DONE 🏊 minikube uninstalled ..."
else
	echo "$color_info 🏊 Minikube already uninstalled..."
fi