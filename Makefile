BRANCH := $(shell git -C .. rev-parse --abbrev-ref HEAD)

ifeq ($(findstring 10,$(BRANCH)),10)
    ROM := AOSP
    NAME := OxygenTech-$(ROM)-10-lavender
    DATE := $(shell date "+%Y%m%d-%H%M")
    ZIP := $(NAME)-$(DATE).zip
else
    ROM := MIUI
    NAME := OxygenTech-$(ROM)-Pie-lavender
    DATE := $(shell date "+%Y%m%d-%H%M")
    ZIP := $(NAME)-$(DATE).zip
endif

EXCLUDE := Makefile *.git* *.jar* *placeholder* *.md* *.zip* LICENSE

normal: $(ZIP)

$(ZIP):
	@echo "Creating ZIP: $(ZIP)"
	@zip -r9 "$@" . -x $(EXCLUDE)
	@echo "Done."

clean:
	@rm -vf *.zip*
	@rm -vf *.gz-dtb
	@rm -vf modules/vendor/lib/modules/*.ko
	@echo "Done."