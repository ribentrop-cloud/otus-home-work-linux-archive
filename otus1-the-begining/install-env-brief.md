
# install Virtual box
sudo yum install kernel-devel kernel-headers make patch gcc  
sudo wget https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -P /etc/yum.repos.d  
sudo yum install VirtualBox-5.2  
systemctl status vboxdrv  

# install packer
curl https://releases.hashicorp.com/packer/1.5.1/packer_1.5.1_linux_amd64.zip | sudo gzip -d > /usr/local/bin/packer  
cd /usr/local/bin/  
chmod +x packer

# install vagrant and configure proxy
wget https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.rpm  
rpm -i vagrant_2.2.7_x86_64.rpm  

#Clone hw repo  
git clone https://github.com/dmitry-lyutenko/manual_kernel_update  

vagrant plugin install vagrant-proxyconf  
export http_proxy="http://user:password@host:port"  
export http_proxy="http://dtrubenkov:Coco1234@172.18.2.216:8080"  
export https_proxy="http://dtrubenkov:Coco1234@172.18.2.216:8080"  
#vagrant plugin install vagrant-proxyconf  
vagrant up  
