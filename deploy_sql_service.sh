#!/bin/sh
repository="https://github.com/gylab-TAU/sql-service-shell-script.git"
base_path="/home/gali/"
directory_name="/home/gali/sql-service-shell-script"
file = "/home/gali/secrets/dbconnector.js"

echo "killing existing service called sqlservice.service"...

if ! systemctl stop sqlservice.service; then
	echo "could not kill sqlservice.service"
else
	echo "successfully killed existing service"
fi

echo "The project: $repository will be cloned into $directory_name. if it exists it will be overridden"
if [ -d $directory_name ];then
	echo "removing folder..."
	if ! rm -Rf $directory_name; then
		echo "failed to remove directory $directory_name"
	else
		echo "directory removed successfully"
	fi
else
	echo "$directory_name not found"
fi

if ! cd $base_path; then
	echo "failed to enter $base_path"
else
	echo "entered $base_path"
fi

echo "cloning $repolisotry..."

if ! git clone $repository; then
	echo "failed to clone $repository"
else
	echo "cloned sycessfully"
fi

if ! cd $directory_name; then
	echo "failed to enter $directory_name"
else
	echo "entered $directory_name"
fi

if [ -f "$file" ]; then
	echo "moving dbconnector to folder..."
	if ! mv $file $directory_name; then
		echo "could not move $file to $directory_name"
	else
		echo "successfuly moved $file to $directory_name"
	fi
else 
	echo "could not find $file"
fi

echo "installing node_modules...."

if ! npm install; then
	echo "failed to install node_modules"
else
	echo "successfully downloaded node_modules"
fi

echo "starting build..."

if ! npm run build; then
	echo "failed to build the app"
else
	echo "build succeeded"
fi

echo "enabling sqlservice.service"

if ! systemctl enable sqlservice.service; then
	echo "failed to enable sqlservice.service"
else
	echo "successfully enabled sqlservice.service"
fi

if ! systemctl start sqlservice.service; then
	echo "failed to start sqlservice.service"
else
	echo "successfully started sqlservice.service"
fi

if ! npm prune; then
	echo "failed pruning dev dependencies"
else
	echo "successfully pruned dev dependencies"
fi

echo "removing src folder..."

if ! rm -Rf $directory_name/src; then
	echo "failed to remove src folder"
else
	echo "sucessfully removed src folder"
fi
echo "*** DONE! *** "