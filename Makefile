NAME = inception

# ====================
#        HEADER
# ====================
define HEADER
	$(CYAN) _____     __     ______     ______     __    __
	$(CYAN)/\  __-.  /\ \   /\  == \   /\  ___\   /\ "-./  \\
	$(CYAN)\ \ \/\ \ \ \ \  \ \  __<   \ \  __\   \ \ \-./\ \\
	$(CYAN) \ \____-  \ \_\  \ \_\ \_\  \ \_____\  \ \_\ \ \_\\
	$(CYAN)  \/____/   \/_/   \/_/ /_/   \/_____/   \/_/  \/_/\
	$(CYAN)
endef
export HEADER

# ====================
#     AINSI COLORS
# ====================
RESET=\033[0m
GREEN=\033[0;32m
CYAN=\033[0;36m
BLUE=\033[0;34m
YELLOW=\033[0;33m
RED=\033[0;31m

# ====================
#      COMMANDS
# ====================
all:
	@clear
	@echo "\n$$HEADER"
	@mkdir -p /home/kami/data/wordpress
	@mkdir -p /home/kami/data/mariadb
	@echo "$(CYAN)Starting $(NAME)...$(RESET)"
	@docker compose -f srcs/docker-compose.yml up -d --build
	@echo "$(GREEN)$(NAME) is up!$(RESET)"

down:
	@echo "$(YELLOW)Stopping $(NAME)...$(RESET)"
	@docker compose -f srcs/docker-compose.yml down
	@echo "$(RED)$(NAME) is down!$(RESET)"

re: down all

clean: down
	@clear
	@echo "\n$(CYAN)   ╔════════════════════════════════╗$(RESET)"
	@echo "$(CYAN)        Cleaning everything...       $(RESET)"
	@echo "$(CYAN)   ╚════════════════════════════════╝$(RESET)"
	@docker system prune -af
	@sudo rm -rf /home/kami/data

fclean: clean
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@clear
	@echo "\n$(CYAN)   ╔════════════════════════════════════════╗$(RESET)"
	@echo "$(CYAN)      All cleaned up! Ready to build fresh! $(RESET)"
	@echo "$(CYAN)   ╚════════════════════════════════════════╝$(RESET)"

.PHONY: all down re clean fclean
