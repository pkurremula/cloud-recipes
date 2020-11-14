package main

import (
	"context"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"syscall"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/sirupsen/logrus"
	"github.com/spf13/pflag"
	"github.com/spf13/viper"
)

const (
	shutdownTimeout = 10 * time.Second
)

var (
	cfg       config
)

type config struct {
	IsWorker bool   `mapstructure:"is-worker"`
	IsMaster bool   `mapstructure:"is-master"`
	Addr     string `mapstructure:"address"`
}

func bindConfig(cfg *config, v *viper.Viper, fs *pflag.FlagSet) {
	fs.Bool("is-worker", false, "worker mode to process jobs")
	fs.Bool("is-master", false, "delegate to be master of the workers")
	fs.String("address", ":8080", "The address to serve on")

	if err := fs.Parse(os.Args); err != nil {
		logrus.Fatalf("can't parse config: %v", err)
	}
	if err := v.BindPFlags(fs); err != nil {
		logrus.Fatalf("can't parse config: %v", err)
	}

	v.AutomaticEnv()
	v.SetEnvKeyReplacer(strings.NewReplacer("-", "_"))

	if err := v.UnmarshalExact(&cfg); err != nil {
		logrus.Fatalf("can't parse config: %v", err)
	}
}

func envHandler() gin.HandlerFunc {
	return func(ctx *gin.Context) {
		ctx.JSON(
			http.StatusOK,
			gin.H{
				"is_worker":  cfg.IsWorker,
				"is_master":  cfg.IsMaster,
				"addr":       cfg.Addr,
			})
	}
}

func main() {
	v := viper.GetViper()
	bindConfig(&cfg, v, pflag.CommandLine)

	// Routes
	gin.SetMode(gin.ReleaseMode)
	router := gin.Default()
	router.GET("/env", envHandler())
	server := http.Server{
		Addr:    cfg.Addr,
		Handler: router,
	}

	// Run the server
	quit := make(chan os.Signal, 1)
	signal.Notify(quit,
		syscall.SIGINT,
		syscall.SIGTERM,
	)

	go func() {
		logrus.Infof("server listening on port %s", cfg.Addr)
		if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
			logrus.Fatalf("error: %v", err)
		}
	}()

	sig := <-quit
	logrus.Infof("received signal %d to shut down", sig)
	ctx, cancel := context.WithTimeout(context.Background(), shutdownTimeout)
	defer cancel()

	if err := server.Shutdown(ctx); err != nil {
		logrus.Fatalf("can't shut down gracefully: %v", err)
	}

	logrus.Info("server shut down gracefully")
}
