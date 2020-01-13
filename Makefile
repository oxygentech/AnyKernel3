DEVICE := $(shell echo ${DEVICE})
BRANCH := $(shell git -C .. rev-parse --abbrev-ref HEAD)

ifeq ($(findstring 10,$(BRANCH)),10)
    ROM := AOSP
    NAME := OxygenTech-$(ROM)-10-$(DEVICE)
    DATE := $(shell date "+%Y%m%d-%H%M")
    ZIP := $(NAME)-$(DATE).zip
else
    ROM := MIUI
    NAME := OxygenTech-$(ROM)-Pie-$(DEVICE)

EXCLUDE := Makefile *.git* *.jar* *placeholder* *.md*

normal: $(ZIP)

$(ZIP):
	sed -i 's/universal/${DEVICE}/g' anykernel.sh
	zip -r9 "$@" . -x $(EXCLUDE)
	echo "Done creating ZIP: $(ZIP)"

clean:
	rm -vf *.zip
	rm -vf *.gz-dtb
	rm -vf modules/vendor/lib/modules/*.ko
	echo "Cleaning done."

